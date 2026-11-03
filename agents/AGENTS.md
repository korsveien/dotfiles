# Personal agent instructions

Applies to all coding agents, regardless of model or tool.

## File references

Write file references as Markdown links with a `file://` URL and a `#L<line>` anchor:

```markdown
[moduleConditions.test.ts:93](file:///Users/me/git/repo/src/modules/moduleConditions.test.ts#L93)
```

The link text is the filename and line; the URL is the absolute path. The terminal renders the
link as a hyperlink, and cmd-click opens the file at that line in Zed. Bare filenames and
relative paths are not clickable, and long plain paths break when the terminal wraps them.

Every mention of a file is a link, also in passing and in lists. If the file is not on disk
(for example outside a sparse checkout), link to a GitHub permalink at a commit SHA instead.

## Norwegian prose

Applies to all Norwegian text: chat answers, PR descriptions, review comments, issues, docs.

- Bokmål, klarspråk as defined by Språkrådet.
- Short and concise. Leave out elaboration the reader does not need.
- Prefer verbs over nouns.
- Use Norwegian word order, not English sentence structure.
- No parenthetical asides with extra detail.

### Examples

| Avoid                                                        | Prefer                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------- |
| Grunnlaget for å fjerne 1 og 2 er det du skrev.              | Jeg fjernet 1 og 2 fordi du skrev at …                  |
| Det reviewen anbefalte, gjør testen alt.                     | Testen gjør allerede det reviewen anbefalte.            |
| Kortet og kontomodulen avgjøres av de samme modulbetingelsene. | Kortet og kontomodulen bruker de samme modulbetingelsene. |
| Skal jeg poste bare funn 4 som en inline-kommentar (som en vanlig «comment», ikke «approve» eller «request changes»)? | Skal jeg poste funn 4 som inline-kommentar? |
| Det som virker best, er konkrete eksempler på feilene jeg gjør, lagt et sted som lastes inn i hver økt. | Konkrete eksempler i AGENTS.md virker best. |
| Skrur brukeren den av, får hen tomt dashboard igjen.         | Skrur brukeren den av blir dashboardet tomt igjen.      |
| Anbefaling: hold modulen utenfor innstillingslistene.        | Hold modulen utenfor innstillingslistene.               |

### Glossary

| Use                         | Not                     | Note                                  |
| --------------------------- | ----------------------- | ------------------------------------- |
| commit, branch              | innsjekk, gren          | English technical terms               |
| committa                    | committet, commitet     | past participle                       |
| diff, diffen                |                         |                                       |
| review, reviewen            | gjennomgang             |                                       |
| poste                       | legge inn               | comments on GitHub                    |
| fjerne (et funn)            | stryke                  |                                       |
| funn                        | punkt                   | what a review finds                   |
| økt                         | sesjon                  | agent session; «sesjon» is a logged-in user session |
| hen                         |                         | when a pronoun for «brukeren» is needed |
| spec, call path             | spesifikasjon, kallvei  | see «PR descriptions»                 |
| lenke                       | link                    |                                       |
| inline-kommentar            |                         | review comment on a line              |

## PR reviews

During a PR review, end every answer with a link to the PR on GitHub
(`https://github.com/<org>/<repo>/pull/<nr>`). Find it with `gh pr view --json url -q .url`.

File references in review findings use the `file://` format from «File references» and point
at a line that the branch changes, so Zed opens the file at the change and shows the diff in the
gutter. Check the line against `git diff -U0 <base>...HEAD` before linking. Zed has no URL that
opens the branch diff view itself. If a finding is about a file the branch does not change, link
to the relevant line in that file.

## PR descriptions

Write PR descriptions in Norwegian, terse, using the template below. A complete example is in
`pr-description-example.md` next to this file (`~/dotfiles/agents/pr-description-example.md`).

### Language

- Norwegian prose, but keep these terms in English: "spec" (definite "specen", plural
  "spec-er", definite plural "spec-ene", verb "specce"), "call path". Not "spesifikasjon",
  "specer", "speccer" or "kallvei".
- Short sentences. No intro, no summary at the end.

### File links

- Every bullet that references a file starts with the link, followed by a colon:
  `- [transformer.ts:42](<diff-link>): slår sammen spec-ene …`
  Never put the link in the middle or at the end of the sentence.
- One file per bullet. If a sentence names two files, split it into two bullets.
- Link to the change in the PR's diff, not to the file, so the reader sees what changed:
  `https://github.com/<org>/<repo>/pull/<nr>/files#diff-<sha256 of the path>R<line>`.
  The hash is the SHA-256 hex digest of the repo-relative path. `R<line>` is a line on the new
  side; for a line that is only deleted, use `L<line>` with the old line number.
- The line must be part of the diff, otherwise GitHub only scrolls to the file. Check against
  `git diff -U0 <base>...HEAD` before linking.
- Files that are not part of the PR get a permalink to a commit SHA:
  `https://github.com/<org>/<repo>/blob/<sha>/<path>#L<line>`.
- Local `file://` links do not work on GitHub.

### Diagrams

- Follow «ASCII diagrams» below.
- One diagram per subsection under «Hvordan», followed by the file bullets.
- Centre each diagram in an 80-column frame with a uniform left margin (see «Placement»).

### Template

````markdown
# Hva

- <What the PR introduces or changes, one point per bullet>
- <What is removed>
- <Behaviour for the user: changed or unchanged>
- <Credit if the setup is based on another team's pattern>

# Hvorfor

1. **<Benefit as a short title>.** <How it worked before>. <What the PR changes>.
2. **<…>.** <…>

# Hvordan

## <Part 1, e.g. Generering>

```
<narrow ASCII diagram>
```

- [<file>:<line>](<permalink>): <what happens here>
- [<file>:<line>](<permalink>): <…>

## <Part 2, e.g. Call path>

```
<before        after>
```

- [<file>:<line>](<permalink>): <…>

# Begrensninger

1. **<Limitation as a short title>.** <Consequence>. <Follow-up issue if any: #nnn>.
2. **<…>.** <…>
````

## ASCII diagrams

Applies to diagrams in code comments, docs, PR descriptions, issues and chat answers. Based
on Hayatpur et al., «Taking ASCII Drawings Seriously: How Programmers Diagram Code»
(CHI '24, https://doi.org/10.1145/3613904.3642683), and on our own conventions.

Keywords SHALL, SHOULD and MAY are normative only in uppercase.

### When to draw

- A diagram SHOULD be used when a structure is easier to see than to read: call paths, data
  flow, graphs and trees, memory or data layouts, state machines, ordering in time (e.g. race
  conditions in columns), before/after, and the setup of a test case.
- A diagram is a thumbnail of the code. It SHALL be less detailed than the code and SHOULD
  give the reader orientation, not repeat every step.
- Mermaid MAY be used where the diagram is only read on GitHub (e.g. a README). Mermaid does
  not render in terminals or editors, and its diffs are harder to read.

### What to show

Pick the parts deliberately (the paper's design space):

- **Concept:** one idea per diagram. Split rather than combine.
- **Visual encoding:** use the form that matches the concept: sequence (`│ ▼`), tree or
  branching (`┌─┼─┐`), graph, table, layout (boxes side by side), columns for time.
- **Annotations:** labels next to or under the element they describe. An annotation that is not
  in place SHALL point at its target with an arrow or marker.
- **Abstraction:** elide with `…` and say what is left out, rather than drawing everything.
- **Subdiagrams:** for before/after or variants, put them side by side with the same encoding
  (e.g. `main` and `branch` columns), so they can be compared line by line.
- **References:** labels SHOULD use the real identifiers, file names and constants from the
  code (`orvalFetcher`, `handlers.ts`), so the reader can find them. These names are not
  updated by rename refactors, so a diagram SHALL be updated in the same change as the code it
  describes.

### Drawing

- **Minimal:** no boxes around labels unless the box carries meaning (a range, a group).
  Arrows pointing at plain text are easier to read and to maintain.
- **Characters:** only single-width characters: ASCII, the box-drawing set `│ ─ ┌ ┐ └ ┘ ├ ┤ ┬
  ┴ ┼`, arrows `▼ ▲ ◀ ▶`, `…`. No emoji, no tabs, no colour.
- **Width:** content SHALL be at most 45 columns, and at most 60 including any centring
  margin. Wide diagrams wrap in diffs and narrow views and fall apart.
- **Direction:** vertical flow, top to bottom, unless the concept is horizontal (a layout, a
  timeline).
- **Axis:** each column of the diagram has one centre line. Labels SHALL be centred on it, and
  `│`/`▼` SHALL sit directly under the middle of the label above. Branches start and end on
  the centre lines of their targets.
- **Legend:** markers with a meaning (e.g. `*` for generated) SHALL be explained in one line
  directly under the diagram.
- **Language:** labels in the same language as the surrounding text. Identifiers stay as in
  the code.

### Placement

- A diagram SHALL be in a fenced code block, so it is rendered in a monospace font.
- In Markdown that is read on a page (PR descriptions, docs), centre the whole diagram in an
  80-column frame by adding the same left margin to every line. Do not use
  `<div align="center">`; it centres each line separately and breaks the shape.
- File trees are left-aligned and are not centred.
- In code comments, the diagram sits directly above the code it describes, at that
  indentation, without centring.
- Commit messages SHOULD NOT contain diagrams; many tools render them in a proportional font.

### Verifying

- Alignment SHALL be computed, not judged by eye: place labels and arrows at fixed columns
  (e.g. with a small script) and check the widest line.
- Before handing over, read the diagram in a monospace view and check that every `│`/`▼` is
  under the middle of its label and that no line exceeds the width limit.
