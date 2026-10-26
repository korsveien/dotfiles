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
