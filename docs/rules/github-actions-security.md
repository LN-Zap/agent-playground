# GitHub Actions Security: Script Injection

When working with GitHub Actions workflows, ensure that untrusted inputs are never interpolated directly into `run` scripts or other execution contexts. Follow GitHub's guidance on avoiding script injection vulnerabilities.

## Guidelines

- Do not use expressions that inject untrusted inputs into shell commands (for example, `run: echo ${{ inputs.name }}` or `run: echo ${{ github.event.issue.title }}`)
- Prefer passing untrusted data through environment variables and reference them safely within scripts
- Use explicit quoting and safe parameter handling
- Validate or sanitize inputs before use when feasible

## Reference

For more information, see [GitHub's documentation on script injections](https://docs.github.com/ja/actions/concepts/security/script-injections).
