# Strike CLI Reference

Detailed command documentation and workflow examples.

## Contents

- [Cash Tab Operations](#cash-tab-operations)
- [Loan Operations](#loan-operations)
- [Loan Simulation](#loan-simulation)
- [Command Chaining](#command-chaining)
- [Natural Language Mapping](#natural-language-mapping)
- [Top Level Commands](#top-level-commands)

---

## Cash Tab Operations

The `cashTab` command handles fiat deposits, withdrawals, and transfers.

### Deposits & Withdrawals

| Intent | Command | Notes |
|--------|---------|-------|
| Deposit | `strike cashTab deposit -a <amount> -e <email>` | Default $21 if `-a` omitted |
| Withdraw | `strike cashTab withdraw -e <email>` | |
| Instant withdraw | `strike cashTab withdrawInstant -e <email>` | Higher fees |
| Withdraw max | `strike cashTab withdrawMax -e <email>` | |

**Payment Method Types (`-t` flag):** Bank, Card, Wire, Push, Sepa, FPS, BSB

### Sending Money

| Intent | Command |
|--------|---------|
| Send on-chain | `strike cashTab sendOnchain <address> <amount> -e <email>` |
| Send lightning | `strike cashTab sendLightning <lnInvoice> -e <email>` |
| Send to Strike user | `strike cashTab sendStrike <amount> <username> -e <email>` |
| Send to LN address | `strike cashTab sendLNAddress <username> <amount> -e <email>` |

### Receiving Money

| Intent | Command |
|--------|---------|
| Receive on-chain | `strike cashTab receiveOnChain <amount> -e <email>` |
| Receive lightning | `strike cashTab receiveLightning <amount> -e <email>` |
| Receive from Strike | `strike cashTab receiveStrike <amount> <username> -e <email>` |

---

## Loan Operations

### Default Values

| Parameter | Default | Notes |
|-----------|---------|-------|
| LTV | 50% | Via collateral multiplier |
| Collateral Multiplier | `-c 2` | 2x loan = 50% LTV |
| Loan Amount | $100,000 | |
| Buffer | 5% | Safety margin |

### Loan Types

| Type | Flag | Alias |
|------|------|-------|
| Monthly Payment | `-t MONTHLY_PAYMENT` | "interest loan" |
| Non-compounding Maturity | `-t NON_COMPOUNDING_MATURITY` | "maturity loan" |
| Pre-computed | `-t PRE_COMPUTED` | |

### Collateral Multiplier Guide

| Multiplier | LTV | Calculation |
|------------|-----|-------------|
| `-c 2` | 50% | 2x loan amount in collateral |
| `-c 3` | 33% | 3x loan amount in collateral |
| `-c 1.67` | 60% | 1.67x loan amount in collateral |

### Calculation Example

For $100k loan at 50% LTV:
- Required collateral: $200,000 (100k × 2)
- With 5% buffer: $210,000 worth of BTC needed

### Loan Flags

| Flag | Description | Values |
|------|-------------|--------|
| `-t` | Loan type | MONTHLY_PAYMENT, NON_COMPOUNDING_MATURITY, PRE_COMPUTED |
| `-a` | Loan amount USD | Default: 100000 |
| `-c` | Collateral multiplier | Default: 2 (50% LTV) |
| `-p` | Principal preference | CASH_BALANCE, COLLATERAL |
| `-i` | Interest preference | CASH_BALANCE, BITCOIN_BALANCE, PAYMENT_METHOD |

### Loan Origination Workflow

```bash
# Create user and originate interest loan
strike kyc fast -e <email>
strike credit fiat 210000 -e <email>      # Fund with buffer
strike bitcoinTab buyMax -e <email>        # Convert to BTC
strike loan originate -t MONTHLY_PAYMENT -a 100000 -c 2 -e <email>
```

---

## Loan Simulation

### Getting Loan ID

```bash
# List loans (returns JSON array)
strike loan loan -e <email>
```

Response includes:
- `id` - Loan ID (required for simulation)
- `name` - Human-readable name
- `health.state` - Loan health status
- `health.currentLtv` - Current LTV ratio

### Simulate Payments

```bash
# Get first loan ID
loan_id=$(strike loan loan -e "$email" | grep -oE '"id": "[^"]+"' | head -n 1 | cut -d'"' -f4)

# Simulate single accrual
strike loan simulateNextAccrual -l "$loan_id" -e "$email"

# Simulate multiple accruals
for i in {1..3}; do
  strike loan simulateNextAccrual -l "$loan_id" -e "$email"
done
```

---

## Command Chaining

### Consumer User Workflow

Create US consumer user, fund, buy bitcoin, originate loan:

```bash
senv=next

# Create consumer user and extract email
email="$(strike kyc fast -c US -s $senv | tee /dev/stderr | grep -oE '[a-zA-Z0-9._%+-]+@test\.zaphq\.io' | head -n 1)"

# Fund with buffer for $100k loan at 50% LTV
strike credit fiat 210000 -s $senv -e "$email"

# Convert to BTC
strike bitcoinTab buyMax -s $senv -e "$email"

# Originate loan
strike loan originate -t MONTHLY_PAYMENT -a 100000 -s $senv -e "$email"
```

### Business User Workflow

Create DE business account, fund $400k, buy max bitcoin, originate loan:

```bash
senv=next

# Create business account and extract email
email="$(strike business account -c DE -s $senv | tee /dev/stderr | grep -oE '[a-zA-Z0-9._%+-]+@test\.zaphq\.io' | head -n 1)"

# Fund and convert
strike credit fiat 400000 -s $senv -e "$email"
strike bitcoinTab buyMax -s $senv -e "$email"

# Originate loan
strike loan originate -s $senv -e "$email" -p CASH_BALANCE -i CASH_BALANCE -t MONTHLY_PAYMENT
```

### Chaining Notes

- `-s` specifies environment (dev, next, local, e2e)
- `-e` specifies user email
- Use shell tools (`grep`, `tee`, `head`) to extract data
- `-c DE` or `-c US` sets country/regulatory region
- Consumer users: Use `strike kyc fast` (default)
- Business users: Use `strike business account`

---

## Natural Language Mapping

### User Creation

| Request | Command |
|---------|---------|
| "create a user" / "mint a user" | `strike kyc fast` |
| "create a user on next" | `strike kyc fast -s next` |
| "create a business user" | `strike business account` |
| "create a user with $500" | `strike kyc fast` → `strike credit fiat 500` |

### Operations

| Request | Commands |
|---------|----------|
| "buy bitcoin" | `strike bitcoinTab buy -a <usd>` |
| "buy max bitcoin" | `strike bitcoinTab buyMax` |
| "sell bitcoin" | `strike bitcoinTab sell -a <usd>` |
| "deposit $100" | `strike cashTab deposit -a 100` |
| "originate a loan" | See Loan Origination Workflow |

---

## Top Level Commands

```
api, business  - Strike's API
activities     - Fetch activities from ActivityService
bitcoinTab     - Bitcoin Tab commands
cashTab        - Cash Tab commands
credit         - Credit fiat or bitcoin to balances
dataTools      - DataTool commands
dca            - List, create, delete DCA configurations
deposits       - ACH Push, ACH Pull and Card Deposits
email          - Send emails
kyc            - Creates users in various KYC states
loan           - Loan management commands
node           - Node related commands
money          - Deprecated money commands
pm             - Creates payment methods
remit          - Sends remittance by provider
token          - Prints user auth token
transactions   - Creates payment transactions
utils          - Utils & high order commands
profile        - Updates user profile
withdrawals    - Withdrawal operations
```
