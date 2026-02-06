# managing-local-stack Evaluation

## Test Matrix

### Capability Mapping

| Cap ID  | Capability                    | Skill Section         | Commands Referenced                      |
| ------- | ----------------------------- | --------------------- | ---------------------------------------- |
| CAP-001 | Start full stack              | Starting Services     | `pnpm start`                             |
| CAP-002 | Start infrastructure only     | Starting Services     | `pnpm infra`                             |
| CAP-003 | Start individual service      | Starting Services     | `dotnet run --project ...`               |
| CAP-004 | Stop services (graceful)      | Stopping Services     | Ctrl+C in terminal                       |
| CAP-005 | Cleanup after crash           | Stopping Services     | `pnpm clean`                             |
| CAP-006 | Complete teardown             | Stopping Services     | `pnpm teardown`                          |
| CAP-007 | Stop specific process         | Stopping Services     | `ps aux`, `kill {PID}`                   |
| CAP-008 | Check running containers      | Checking Status       | `docker ps`                              |
| CAP-009 | Check service health          | Checking Status       | `curl -skf https://localhost:{port}/...` |
| CAP-010 | Access dashboard              | Checking Status       | Navigate to dashboard URL                |
| CAP-011 | Wait for infrastructure       | Waiting for Readiness | Log polling with grep                    |
| CAP-012 | Wait for dashboard            | Waiting for Readiness | curl loop                                |
| CAP-013 | Wait for service health       | Waiting for Readiness | curl health endpoint loop                |
| CAP-014 | Use launch profiles           | Launch Profiles       | Profile selection via pnpm scripts       |
| CAP-015 | Configure env variables       | Environment Variables | APP_* variables                          |
| CAP-016 | Troubleshoot port conflict    | Troubleshooting       | `lsof -i :PORT`                          |
| CAP-017 | Troubleshoot container issues | Troubleshooting       | `docker ps -a`                           |
| CAP-018 | Troubleshoot DB connection    | Troubleshooting       | `docker exec` psql                       |

### Mission Definitions

#### Mission 1: Start Infrastructure (Happy Path)

- **Capability**: CAP-002
- **Persona**: DevOps Operator
- **Objective**: Start infrastructure and verify readiness
- **DoD**: Database initialization message in logs, dashboard accessible
- **Result**: ✅ PASS - All commands worked as documented
- **Friction**: Minor - Dashboard returns 302 not 200

#### Mission 2: Start Infrastructure (Edge Case - Already Running)

- **Capability**: CAP-002
- **Persona**: DevOps Operator
- **Objective**: Handle case where infrastructure is already running
- **DoD**: Detect existing state, avoid double-start, or gracefully handle
- **Result**: ⚠️ GAP - No pre-flight check documented
- **Fix Applied**: Added "Before Starting: Pre-flight Check" section

#### Mission 3: Stop Services (Happy Path)

- **Capability**: CAP-004
- **Persona**: DevOps Operator
- **Objective**: Gracefully stop running services
- **DoD**: All managed processes terminated, ports released
- **Result**: ⚠️ GAP - Ctrl+C only, no programmatic alternative
- **Fix Applied**: Added "When Ctrl+C Is Not Available" section with kill -SIGINT

#### Mission 5: Check Service Health (Edge Case - Unknown Port)

- **Capability**: CAP-009
- **Persona**: Junior Developer
- **Objective**: Find port for service not explicitly documented
- **DoD**: Discover port from launchSettings.json, verify health
- **Result**: ✅ PASS - Path pattern and grep command worked
- **Friction**: Minor - Multiple ports in output (HTTPS vs HTTP)

#### Mission 6: Cleanup After Crash (Stress Test)

- **Capability**: CAP-005
- **Persona**: DevOps Operator
- **Objective**: Clean up orphaned containers after simulated crash
- **DoD**: All app-* containers removed, ready for fresh start
- **Result**: ✅ PASS - Cleanup commands worked
- **Friction**: Medium - Interactive prompts not documented
- **Fix Applied**: Added `yes |` prefix guidance

#### Mission 7: Wait for Readiness (Happy Path)

- **Capability**: CAP-011
- **Persona**: CI Engineer
- **Objective**: Script automated wait for infrastructure readiness
- **DoD**: Script exits when infrastructure ready
- **Result**: ⚠️ GAP - Inline pattern incomplete for production use
- **Fix Applied**: Added scripts/wait-for-infrastructure.sh reference

#### Mission 8: Troubleshoot Port Conflict (Edge Case)

- **Capability**: CAP-016
- **Persona**: Junior Developer
- **Objective**: Resolve port already in use error
- **DoD**: Identify process, terminate it, retry start
- **Result**: ⚠️ GAP - Unsafe "just kill" advice
- **Fix Applied**: Added process identification table and decision matrix

______________________________________________________________________

## Execution Logs Summary

### Environment States

| Mission | Initial State           | Final State            |
| ------- | ----------------------- | ---------------------- |
| 1       | Clean                   | 13 containers running  |
| 2       | Running                 | Running (unchanged)    |
| 3       | Running                 | Analysis only          |
| 5       | Running                 | Running (unchanged)    |
| 6       | Orphaned containers     | Clean                  |
| 7       | Clean                   | Infrastructure running |
| 8       | Port conflict simulated | Analysis only          |

### Skill Reliability Metrics

| Metric             | Value      |
| ------------------ | ---------- |
| Happy Path Success | 100% (3/3) |
| Edge Case Success  | 50% (2/4)  |
| Overall Success    | 71% (5/7)  |
| Avg Friction (1-5) | 2.4        |

### Final Grade: **C (71%)**

See [reference.md](reference.md) for complete RCA report.
