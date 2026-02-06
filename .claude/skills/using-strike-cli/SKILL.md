---
name: using-strike-cli
description: >-
  Executes strike CLI commands for user creation, funding, bitcoin operations,
  loans, and cash transactions. Use when creating users, minting users, funding
  accounts, buying/selling bitcoin, originating loans, making
  deposits/withdrawals, or any strike command.
---
# Using Strike CLI

Executes the `strike` CLI tool for test user management and operations.

## When to Use This Skill

- Creating or minting users (consumer or business)
- Funding user accounts with fiat or bitcoin
- Bitcoin buy/sell/send operations
- Loan origination and simulation
- Cash deposits, withdrawals, and transfers
- Running any `strike` command

## Mandatory Rules

1. **Consumer users by default**: Use `strike kyc` unless explicitly asked for business account
2. **Custom emails**: Use `strike kyc` (not `kyc fast`) with `-e` flag for custom email addresses. `kyc fast` ignores the email flag and generates random emails.
3. **Always discover flags**: Run `strike [command] --help` when unsure of flags
4. **Use `cashTab deposit` for deposits**: NOT `deposits pull`
5. **Chain commands sequentially**: Create → Fund → Execute operation
6. **Sandbox flag `-s` must be LAST**: When specifying an environment, always place `-s <env>` at the end of commands to avoid parsing issues
7. **Default environment is `dev`**: If no environment is specified, commands target `dev`. Only use `-s` when targeting `next`, `local`, or `e2e`.
8. **Loan vs Line of Credit**: These are DIFFERENT products with DIFFERENT commands:
   - **"loan"** → Use `strike loan` commands (term loans with fixed repayment)
   - **"line of credit" / "LoC"** → Use `strike loc` commands (revolving credit line)

## Quick Start

```bash
# Create a consumer user with random email (dev is default)
strike kyc fast

# Create a consumer user with custom email (dev)
strike kyc -e myemail@test.zaphq.io

# Create a consumer user on next environment
strike kyc -e myemail@test.zaphq.io -s next

# Create a business user in a specific state (next)
strike business account -t CA -e myemail@test.zaphq.io -s next

# Fund user (dev - no -s needed)
strike credit fiat 1000 -e <email>
strike credit btc 2 -e <email>

# Fund user (next)
strike credit fiat 1000 -e <email> -s next
strike bitcoinTab buyMax -e <email> -s next
```

## Command Quick Reference

| Intent | Command |
|--------|---------|
| Create consumer user (random email) | `strike kyc fast` |
| Create consumer user (custom email) | `strike kyc -e <email>` |
| Create business user | `strike business account` |
| Create business user in US state | `strike business account -t <STATE> -e <email>` |
| Add fiat | `strike credit fiat <amount> -e <email>` |
| Add bitcoin | `strike credit btc <btc_amount> -e <email>` |
| Buy bitcoin | `strike bitcoinTab buy -a <usd> -e <email>` |
| Buy max bitcoin | `strike bitcoinTab buyMax -e <email>` |
| Sell bitcoin | `strike bitcoinTab sell -a <usd> -e <email>` |
| Deposit | `strike cashTab deposit -a <amount> -e <email>` |
| Withdraw | `strike cashTab withdraw -e <email>` |
| Originate term loan | `strike loan originate -e <email>` |
| Originate line of credit | `strike loc originate -e <email>` |

> **Note**: `credit btc` takes BTC as decimal (e.g., `2` for 2 BTC), NOT satoshis.
> 
> **Environment**: Commands above target `dev` (default). Add `-s next` at the END for other environments.
>
> **Loan vs LoC**: "loan" = `strike loan` (term loan), "line of credit" = `strike loc` (revolving credit).

## Global Flags

```
-s, --sandbox [env]   Environment: dev (default), next, local, e2e — ALWAYS PUT LAST
-e, --email <email>   User email (default: zap-qa-cli@test.zaphq.io)
-v, --verbose         Show HTTP request info
-d, --debug           Show JSON requests/responses
```

## Discovery Protocol

When unsure of specific flags:

1. **Identify** the top-level command (`kyc`, `loan`, `cashTab`, etc.)
2. **Run** `strike [command] --help`
3. **Execute** with discovered flags

## Loan Origination Defaults

When user requests loan without parameters:
- **LTV**: 50% (collateral multiplier `-c 2`)
- **Amount**: $100,000
- **Buffer**: 5% extra collateral
- **Type**: MONTHLY_PAYMENT (unless specified)

Quick workflow:
```bash
strike kyc fast
strike credit fiat 210000 -e <email>  # With 5% buffer
strike bitcoinTab buyMax -e <email>
strike loan originate -t MONTHLY_PAYMENT -a 100000 -c 2 -e <email>
```

## Top Level Commands

```
kyc            - Creates users in various KYC states
api, business  - Strike's API (business accounts)
bitcoinTab     - Bitcoin buy/sell/send operations
cashTab        - Deposits, withdrawals, transfers
credit         - Credit fiat or bitcoin to balances
loan           - Term loan commands (fixed repayment schedule)
loc            - Line of Credit commands (revolving credit)
pm             - Creates payment methods
dca            - DCA configurations
activities     - Fetch activities
deposits       - ACH Push/Pull and Card Deposits
withdrawals    - Withdrawal operations
```

## Post-Session Reflection

After completing CLI operations, consider triggering reflection if:
- A command failed unexpectedly
- You discovered a missing flag or undocumented behavior
- The workflow took longer than expected

```
> Reflect on this session

Context:
- Skill: using-strike-cli
- Commands run: [list]
- Friction: [describe issue]
```

The `performing-self-reflection` skill will route findings to:
- `using-strike-cli/reference.md` for missing commands/flags
- `copilot-instructions.md` for workflow patterns
- `.ai-context/skills-roadmap.md` for larger gaps

## Reference

**Detailed commands, workflows & examples**: See [reference.md](reference.md)
