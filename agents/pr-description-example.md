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

- [orval.config.ts:4](https://github.com/sparebank1utvikling/awl-monorepo/blob/d8487c4ab2c76336cf22ecac6b84718907caac9c/apps/team-bank-og-regnskap/kundefront-bm-min-bedrift/frontend/orval.config.ts#L4): `fetch`-klient, MSW-mocker, `orvalFetcher` som mutator.
- [transformer.ts:42](https://github.com/sparebank1utvikling/awl-monorepo/blob/d8487c4ab2c76336cf22ecac6b84718907caac9c/apps/team-bank-og-regnskap/kundefront-bm-min-bedrift/frontend/openapi/document-archive/transformer.ts#L42): slår sammen spec-ene og beholder bare `OPERATIONS_IN_USE`.
- [document-archive.ts:27](https://github.com/sparebank1utvikling/awl-monorepo/blob/d8487c4ab2c76336cf22ecac6b84718907caac9c/apps/team-bank-og-regnskap/kundefront-bm-min-bedrift/frontend/src/api-generated/endpoints/document-archive.ts#L27): generert kode, committet.

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

- [api/index.ts:5](https://github.com/sparebank1utvikling/awl-monorepo/blob/d8487c4ab2c76336cf22ecac6b84718907caac9c/apps/team-bank-og-regnskap/kundefront-bm-min-bedrift/frontend/src/api/index.ts#L5): setter `Accept` og CSRF-token. Feilhåndteringen er som før.
- [utils/api.ts:1](https://github.com/sparebank1utvikling/awl-monorepo/blob/d8487c4ab2c76336cf22ecac6b84718907caac9c/apps/team-bank-og-regnskap/kundefront-bm-min-bedrift/frontend/src/utils/api.ts#L1): mock-grenen er fjernet.
- I hookene er bare `queryFn` endret. Query keys, `enabled` og timeout er uendret.
  - [useDob.ts:167](https://github.com/sparebank1utvikling/awl-monorepo/blob/d8487c4ab2c76336cf22ecac6b84718907caac9c/apps/team-bank-og-regnskap/kundefront-bm-min-bedrift/frontend/src/state/queryData/useDokumenterOgBilag/useDob.ts#L167): `searchDocuments`
  - [useDobGroups.ts:52](https://github.com/sparebank1utvikling/awl-monorepo/blob/d8487c4ab2c76336cf22ecac6b84718907caac9c/apps/team-bank-og-regnskap/kundefront-bm-min-bedrift/frontend/src/state/queryData/useDokumenterOgBilag/useDobGroups.ts#L52): `listDocumentGroups`
  - [useDobDownload.ts:24](https://github.com/sparebank1utvikling/awl-monorepo/blob/d8487c4ab2c76336cf22ecac6b84718907caac9c/apps/team-bank-og-regnskap/kundefront-bm-min-bedrift/frontend/src/state/queryData/useDokumenterOgBilag/useDobDownload.ts#L24): `getDocument`

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
- [vitest-setup.ts:1](https://github.com/sparebank1utvikling/awl-monorepo/blob/d8487c4ab2c76336cf22ecac6b84718907caac9c/apps/team-bank-og-regnskap/kundefront-bm-min-bedrift/frontend/vitest-setup.ts#L1): starter og stopper MSW-serveren.
- [test-server.ts:4](https://github.com/sparebank1utvikling/awl-monorepo/blob/d8487c4ab2c76336cf22ecac6b84718907caac9c/apps/team-bank-og-regnskap/kundefront-bm-min-bedrift/frontend/src/test-server.ts#L4): registrerer de genererte handlerne som standard.
- [useDob.hook.test.ts:75](https://github.com/sparebank1utvikling/awl-monorepo/blob/d8487c4ab2c76336cf22ecac6b84718907caac9c/apps/team-bank-og-regnskap/kundefront-bm-min-bedrift/frontend/src/state/queryData/useDokumenterOgBilag/useDob.hook.test.ts#L75): testene overstyrer med `server.use(…)`.

**dev:mock:**
- [vite.config.ts:10](https://github.com/sparebank1utvikling/awl-monorepo/blob/d8487c4ab2c76336cf22ecac6b84718907caac9c/apps/team-bank-og-regnskap/kundefront-bm-min-bedrift/frontend/vite.config.ts#L10): bytter inngangspunkt til `mocks/main.ts`.
- [mocks/main.ts:6](https://github.com/sparebank1utvikling/awl-monorepo/blob/d8487c4ab2c76336cf22ecac6b84718907caac9c/apps/team-bank-og-regnskap/kundefront-bm-min-bedrift/frontend/mocks/main.ts#L6): starter MSW-workeren og laster appen.
- [handlers.ts:39](https://github.com/sparebank1utvikling/awl-monorepo/blob/d8487c4ab2c76336cf22ecac6b84718907caac9c/apps/team-bank-og-regnskap/kundefront-bm-min-bedrift/frontend/mocks/handlers.ts#L39): handlere skrevet for hånd med realistiske data. URL-ene til arkivet er generert.

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

