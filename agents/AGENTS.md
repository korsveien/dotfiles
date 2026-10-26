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
  `- [transformer.ts:42](<permalink>): slår sammen spec-ene …`
  Never put the link in the middle or at the end of the sentence.
- One file per bullet. If a sentence names two files, split it into two bullets.
- Use permalinks to a commit SHA, not the branch name:
  `https://github.com/<org>/<repo>/blob/<sha>/<path>#L<line>`. The SHA must be pushed.
  Branch links break when the branch is deleted, and the line numbers move.
- Local `file://` links do not work on GitHub.

### Diagrams

- Minimal ASCII in code blocks, narrow enough (about 45 characters) to avoid horizontal
  scrolling. Vertical flow with `│` and `▼`.
- One diagram per subsection under «Hvordan», followed by the file bullets.

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
