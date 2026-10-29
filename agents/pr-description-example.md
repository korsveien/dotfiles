# Hva

- Innfører [orval](https://orval.dev/) som genererer http-klienter basert på OpenAPI-spec.
- Typer og MSW-mocker genereres fra de samme spec-ene.
- Håndskrevne kall, typer og mock-kode i `@utils/api` er fjernet.
- Oppførselen for brukeren er uendret.
- Basert på eksisterende oppsett i team-finansiering

# Hvorfor

1. **Typer fra specen.** De håndskrevne typene kunne drifte fra API-et. Nå gir en endret spec typefeil når klienten genereres på nytt.
2. **Mindre håndskrevet kode.** URL-er, parametre og `get`/`post` + `handleResponses` per endepunkt er erstattet av genererte, typede funksjoner.
3. **Ingen mock-kode i produksjon.** `VITE_USE_MOCK`-grenen i `@utils/api` er fjernet. MSW tar kallene på nettverksnivå, og workeren holdes utenfor prod-bygget.
4. **Hookene testes som ekte nettverkskall.** Testene kjører `orvalFetcher` og `fetch`. De dekker body, paging, antall uleste, 503, tilgangssjekker og nedlasting.
5. **Umockede kall feiler.** Med `onUnhandledRequest: 'error'` feiler en test som gjør et kall uten mock.
6. **Mockene følger specen.** Testmockene er generert, og `dev:mock` bruker genererte URL-er.
7. **Mer komplett `dev:mock`.** Keepalive og landingsside er mocket, så nettverksfanen er fri for 404-støy. Nettleser åpnes automatisk.

# Hvordan

## Generering

```
openapi/document-archive/*.json
  (3 spec-er, kopiert fra arkivet)
            │
            ▼
transformer.ts
  slår sammen 3 spec-er til 1
            │
            ▼   npm run orval
src/api-generated/
  ├─ endpoints/  funksjoner
  ├─ model/      typer
  └─ *.msw.ts    mock-handlere
```

- [orval.config.ts:4](https://github.com/sparebank1utvikling/awl-monorepo/pull/115827/files#diff-d07d501da49c456003e1f1181200b7a7fdd4d2b884f1a79577b431f055fdbdd1R4): `fetch`-klient, MSW-mocker, `orvalFetcher` som mutator.
- [transformer.ts:42](https://github.com/sparebank1utvikling/awl-monorepo/pull/115827/files#diff-451785f271e7e61f15ac11ac4bc939d897e31b38518ad55f684d5f91936c4a7eR42): slår sammen spec-ene og beholder bare `OPERATIONS_IN_USE`.
- [document-archive.ts:27](https://github.com/sparebank1utvikling/awl-monorepo/pull/115827/files#diff-8b159ed1cde28f54e27b57ececb91eb6004794d798280b511dfa28761e237bddR27): generert kode, committet.

## Call path

```
main                 branch
────                 ──────
hook                 hook
 │                    │
 ▼                    ▼
get()/post()         searchDocuments() …
 │ (mock?)            │
 ▼                    ▼
fetch                orvalFetcher
 │                    │
 ▼                    ▼
handleResponses      fetch
                      │
                      ▼
                     handleResponses
```

- [api/index.ts:5](https://github.com/sparebank1utvikling/awl-monorepo/pull/115827/files#diff-a994305944c2770d8ed8f3f158c5faac6c8298c04cdbcb377bed35b55547f75dR5): setter `Accept` og CSRF-token. Feilhåndteringen er som før.
- [utils/api.ts:14](https://github.com/sparebank1utvikling/awl-monorepo/pull/115827/files#diff-fffbf83140d658a238f6ac0a002e8efffce98a379e58d3bc73217e67a2b0d745L14): mock-grenen er fjernet.
- I hookene er bare `queryFn` endret. Query keys, `enabled` og timeout er uendret.
  - [useDob.ts:167](https://github.com/sparebank1utvikling/awl-monorepo/pull/115827/files#diff-ccfc51e39ffd8b6cddf28f499a0e830954e0cde9528dcdeba8ae83657858d7b1R167): `searchDocuments`
  - [useDobGroups.ts:52](https://github.com/sparebank1utvikling/awl-monorepo/pull/115827/files#diff-ffb1e0c760f44ff10a9ab7df9c5be9ddc44418ecfc95265b0dda00cf4c92876eR52): `listDocumentGroups`
  - [useDobDownload.ts:24](https://github.com/sparebank1utvikling/awl-monorepo/pull/115827/files#diff-e9493c27c4c418f9b0f3f8b4483e4c18efb7932f2775e8d0fc5363bbdc23f22aR24): `getDocument`

## Mocker

```
        fetch()
           │
     ┌─────┴──────┐
     ▼            ▼
  vitest       dev:mock
  msw/node     msw/browser
     │            │
     ▼            ▼
  genererte    mocks/
  handlere     handlers.ts
```

**Test:**
- [vitest-setup.ts:1](https://github.com/sparebank1utvikling/awl-monorepo/pull/115827/files#diff-403233ec74bd33c82ba9ac0fa2f654a7ce293a38a5949e1e6bc2af376d9783e1R1): starter og stopper MSW-serveren.
- [test-server.ts:4](https://github.com/sparebank1utvikling/awl-monorepo/pull/115827/files#diff-809a73f2f3db91db40b9aff804a9aa50c77b93c2f5bf7a4e3cd9967b3ca4458aR4): registrerer de genererte handlerne som standard.
- [useDob.hook.test.ts:75](https://github.com/sparebank1utvikling/awl-monorepo/pull/115827/files#diff-63609238b7eedbdd0e9f885b5bb2313e5bea96aa8f77b040aa603f1cbc3bb6aaR75): testene overstyrer med `server.use(…)`.

**dev:mock:**
- [vite.config.ts:10](https://github.com/sparebank1utvikling/awl-monorepo/pull/115827/files#diff-7ed5b2d39af8436acb6e948c9f0b370eba981ae26df61112da8eb47971b63f27R10): bytter inngangspunkt til `mocks/main.ts`.
- [mocks/main.ts:6](https://github.com/sparebank1utvikling/awl-monorepo/pull/115827/files#diff-73b4fe38e57d5822f2c36132c8eec8d08055a3392e415f3a1e1399a1e28d9e86R6): starter MSW-workeren og laster appen.
- [handlers.ts:39](https://github.com/sparebank1utvikling/awl-monorepo/pull/115827/files#diff-ff914df6a99783295dd91737d069185f53b9ccd4ef7ae841b74d7fd9927bcad8R39): handlere skrevet for hånd med realistiske data. URL-ene til arkivet er generert.

# Begrensninger

1. **Spec-ene er kopier.** Endringer i arkivets API fanges ikke opp. Spec-ene må hentes på nytt for hånd.
2. **Genereringen er manuell.** `npm run orval` kjøres ikke i bygg eller CI.
3. **Ingen genererte react-query-hooks.** Med `client: 'fetch'` har hookene egne query keys.
4. **Transformeren gjør header- og cookie-parametre om til query-parametre.** Det påvirker ikke dagens spec. Fulgt opp i #119009.
5. **Uklar feil fra transformeren.** Mangler en operasjon i specen, feiler `npm run orval` med en generisk `TypeError`.
6. **`dev:mock`-dataene er håndskrevne.** Bare URL-ene kommer fra specen.
7. **`public/` er slått av i prod-bygget.** Filer som legges der senere, kommer ikke med.
8. **`MessageTypeName`-cast.** `messageTypeName` er `string` i den genererte modellen og castes til unionen. Det fungerer som på main.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

