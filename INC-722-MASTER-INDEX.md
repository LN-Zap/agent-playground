# INC-722 Master Index
**Distributed spam attack on `/api/v0.0.1/user/phone` endpoint**

*Investigation completed: February 9, 2026*

---

## 🚀 Quick Links

### For Executives
- [📄 Executive Brief](INC-722-REPORTS/final/INC-722-FINAL-COMPREHENSIVE-REPORT.md#executive-summary) (See executive summary section in comprehensive report)

### For Security Team
- [📊 Full Technical Report](INC-722-REPORTS/final/INC-722-FINAL-COMPREHENSIVE-REPORT.md) (22 pages, all verified data)
- [🛠️ Self-Reflection](INC-722-REPORTS/final/INC-722-SELF-REFLECTION.md) (Process improvements)
- [🎯 Master Prompt](INC-722-REPORTS/final/INC-MASTER-PROMPT.md) (Framework for future investigations)

### For Engineers
- [📁 Agent Data](INC-722-REPORTS/agent-data/) (Raw API outputs from 5 agents)
- [📈 Analysis Files](INC-722-REPORTS/analysis/) (Intermediate analysis documents)
- [🔧 Artifacts](INC-722-REPORTS/artifacts/) (Scripts, API responses, logs)

### Twilio Deep-Dive
- [📞 Twilio Usage & Financial Impact Analysis](INC-722-REPORTS/investigations/twilio-usage-analysis.md) (Comprehensive Twilio CLI investigation)

### PagerDuty Alerting
- [🔔 PagerDuty Alerting Effectiveness Analysis](INC-722-REPORTS/investigations/pagerduty-alerting-analysis.md) (Alert coverage, response times, critical gaps)

### Archives
- [📝 Drafts](INC-722-REPORTS/drafts/) (Superseded reports with unverified estimates)

---

## 📈 Key Metrics (API Verified)

| Metric | Value |
|--------|-------|
| **Total Requests** | 1,792,953 |
| **Phone Endpoint** | 729,113 (40.7%) |
| **Attack Duration** | 7 hours (Feb 8, 21:00 - Feb 9, 04:00 UTC) |
| **Peak Rate** | 608,450 req/hour |
| **Financial Impact** | $9,251 excess Twilio cost ($8,579 Lookups Feb 8 + $701 Feb 9) |
| **Malicious JA4** | `t13d1516h2_8daaf6152771_d8a2da3f94cd` (505k reqs) |
| **Attack IPs** | 20,386 unique IPs |
| **Primary ASN** | AWS (66.8%), Google Cloud (26%) |
| **Rate Limit Blocks** | 450 (0.03% effective) |

---

## 🎯 Key Findings

### Root Cause
**Rate limit misconfiguration:** Used `cf.unique_visitor_id` characteristic instead of `ip.src`, allowing attackers to bypass by creating new user accounts. Each of 20,386 IPs sent only 25 requests over 7 hours (0.06 req/min), well below the 10 req/30s threshold.

### Attack Profile
- **Method:** Distributed POST requests to `/api/v0.0.1/user/phone`
- **Infrastructure:** 94.2% from cloud providers (AWS 66.8%, GCP 26%)
- **TLS Fingerprint:** `t13d1516h2_8daaf6152771_d8a2da3f94cd` (TLS 1.3, Node.js client)
- **User-Agent:** `node`, `http/0.5.3.1`
- **Pattern:** Low-and-slow distributed attack (25 req/IP over 7 hours)

### Mitigation
**Effective action:** Application-level rate limit (5 requests/hour per user account) deployed at 03:49 UTC stopped attack immediately.

### Lessons Learned
1. Always query Cloudflare APIs directly (don't trust dashboard screenshots)
2. Deploy agents in parallel for 5x faster investigation
3. Verify all metrics before generating reports
4. Use `ip.src` + `cf.bot_management.ja4` for rate limiting, NOT `cf.unique_visitor_id`

---

## 📂 Directory Structure

```
INC-722-REPORTS/
├── final/
│   ├── INC-722-FINAL-COMPREHENSIVE-REPORT.md  (22-page verified report)
│   ├── INC-722-SELF-REFLECTION.md              (Process analysis)
│   └── INC-MASTER-PROMPT.md                    (Framework for future)
├── agent-data/
│   ├── INC-722-AGENT2-ASN-DUPLICATE.json       (Duplicate ASN report)
│   ├── INC-722-AGENT3-STATUS-CODE-REPORT.json  (Status code breakdown)
│   ├── INC-722-ASN-INTELLIGENCE-REPORT.json    (ASN analysis)
│   ├── INC-722-JA4-ANALYSIS-REPORT.json        (TLS fingerprints)
│   ├── INC-722-RATE-LIMIT-FORENSICS.json       (Rate limit investigation)
│   └── INC-722-TRAFFIC-VOLUME-REPORT.json      (Traffic metrics)
├── analysis/
│   ├── INC-722-AGENT3-STATUS-CODE-ANALYSIS.md  (Status code analysis)
│   ├── INC-722-ASN-ANALYSIS.md                 (ASN breakdown)
│   ├── INC-722-ASN-TOP-20.csv                  (Top 20 ASNs CSV)
│   ├── INC-722-JA4-EXECUTIVE-SUMMARY.md        (JA4 summary)
│   └── asn_summary.txt                         (ASN text summary)
├── artifacts/
│   ├── AGENT-4-COMPLETION-REPORT.md            (Agent 4 status)
│   ├── analyze_status_codes.py                 (Python analysis script)
│   ├── asn_query.json                          (GraphQL ASN query)
│   ├── asn_response.json                       (API response)
│   ├── firewall_asn_query.json                 (Firewall events query)
│   ├── firewall_asn_response.json              (Firewall response)
│   ├── hourly_traffic_query.json               (Traffic query)
│   ├── introspection_query.json                (GraphQL schema)
│   ├── path_breakdown.json                     (Endpoint breakdown)
│   └── process_asn_data.py                     (ASN processing script)
├── drafts/
│   ├── INC-722-EXECUTIVE-BRIEF.md              (Old version w/ estimates)
│   ├── INC-722-INVESTIGATION-GUIDE.md          (Manual investigation guide)
│   ├── INC-722-QUICK-QUERIES.md                (Quick query reference)
│   └── INC-722-SUMMARY-REPORT.md               (Old version w/ estimates)
└── investigations/
    ├── 422-root-cause-analysis.md              (422 status code analysis)
    ├── bot-score-analysis.md                   (Bot score investigation)
    ├── cf-unique-visitor-id.md                 (Visitor ID analysis)
    ├── ja4-fingerprint-investigation.md        (JA4 fingerprint deep-dive)
    ├── pagerduty-alerting-analysis.md          (PagerDuty alerting effectiveness)
    └── twilio-usage-analysis.md                (Twilio CLI financial impact)
```

---

## ✅ Investigation Status

- [x] Data gathered from Cloudflare APIs
- [x] Root cause identified (cf.unique_visitor_id misconfiguration)
- [x] Malicious JA4 fingerprint extracted (safe to block)
- [x] Financial impact verified ($9,251 excess Twilio Lookups, confirmed via Twilio CLI)
- [x] Comprehensive report generated (22 pages)
- [x] Files organized professionally
- [x] Self-reflection documented
- [x] Master prompt created for future investigations
- [ ] Stakeholders notified (pending)
- [ ] Post-mortem scheduled (pending)
- [ ] Action items assigned (pending)

---

## 🔴 Recommended Actions

### Immediate (0-24 hours)
1. **Block malicious JA4 fingerprint** `t13d1516h2_8daaf6152771_d8a2da3f94cd` via WAF rule
   - Owner: Security Team
   - Due: Feb 10, 2026

2. **Update rate limit rule** to use `[ip.src, cf.bot_management.ja4]` characteristics
   - Replace: `cf.unique_visitor_id`
   - Threshold: 5 req/30s (stricter than current 10 req/30s)
   - Owner: Security Team
   - Due: Feb 10, 2026

### Short-term (1-7 days)
3. **Implement bot management** for `/user/phone` endpoint
   - Enable Cloudflare Bot Management
   - Score threshold: < 30 = block
   - Owner: Engineering Team
   - Due: Feb 16, 2026

4. **Add CAPTCHA challenge** for phone verification
   - Trigger: 3 failed verifications per IP per hour
   - Owner: Product Team
   - Due: Feb 16, 2026

5. **Set up alerting** for similar attack patterns
   - Alert if: Phone endpoint > 50k req/hour
   - Alert if: Twilio spend > $1k/hour
   - Owner: DevOps Team
   - Due: Feb 12, 2026

### Long-term (1-4 weeks)
6. **Audit all rate limit rules** for similar misconfigurations
   - Check all rules using `cf.unique_visitor_id`
   - Migrate to IP + JA4 based rules
   - Owner: Security Team
   - Due: March 9, 2026

7. **Implement cost anomaly detection** for Twilio
   - Alert if spending > 2x daily average
   - Integration: Twilio webhooks → PagerDuty
   - Owner: Finance + Engineering
   - Due: March 2, 2026

8. **Schedule post-mortem** with full team
   - Date: Feb 12, 2026
   - Attendees: Engineering, Security, Product, Finance
   - Owner: Engineering Manager

---

## 📊 Agent Performance

| Agent | Role | Status | Data Quality | Runtime |
|-------|------|--------|--------------|---------|
| Agent 1 | Traffic Volume | ✅ Complete | HIGH | ~3 min |
| Agent 2 | ASN Intelligence | ✅ Complete | HIGH | ~4 min |
| Agent 3 | Status Code Analysis | ✅ Complete | HIGH | ~3 min |
| Agent 4 | JA4 Fingerprints | ✅ Complete | HIGH | ~5 min |
| Agent 5 | Rate Limit Forensics | ✅ Complete | HIGH | ~4 min |

**Total investigation time:** ~90 minutes (including data reconciliation and report writing)

---

## 🔍 Data Sources

1. **Cloudflare GraphQL Analytics API** (Primary)
   - httpRequests1hGroups dataset
   - 7-hour attack period: Feb 8 21:00 - Feb 9 04:00 UTC
   - Verified 1,792,953 total requests

2. **Cloudflare Firewall Events API**
   - firewallEventsAdaptiveGroups dataset
   - ASN and geographic distribution
   - 32,000 events sampled

3. **Cloudflare REST API**
   - WAF rules and configuration
   - Rate limit rule details

4. **Twilio Billing Dashboard**
   - $8,578.62 Lookup API charges verified
   - Screenshot captured for audit trail

5. **Twilio CLI Investigation** (NEW)
   - Usage records: 19 categories, daily breakdown Feb 5-9
   - Verify attempts: per-day + attack window breakdown
   - Alerts: 39 during attack (38× error 60205)
   - Refined total excess: $9,251 (Lookups + CallerID + LineType)
   - Full report: `INC-722-REPORTS/investigations/twilio-usage-analysis.md`

6. **PagerDuty Alerting Analysis** (NEW)
   - 37 production alerts during attack window across 14 services
   - 4 HIGH urgency, 33 LOW urgency; first alert at 21:13 (13 min into attack)
   - Critical gaps: Phone Live service fired zero alerts, Security EP never paged, no Twilio cost alerting exists
   - On-call roster: Consumer Backend (Leonard Samples), Platform (Mariusz Kotas), SRE (Ron Ballesteros), Security (Grant Miller — never paged)
   - 8 prioritized recommendations for alerting improvements
   - Full report: `INC-722-REPORTS/investigations/pagerduty-alerting-analysis.md`

7. **Application Logs** (Incident channel)
   - Attack detection timeline
   - Mitigation deployment logs

---

## 📞 Contact

**Investigation Lead:** AI Agent (GitHub Copilot)  
**Human Reviewer:** Tom (Security Team)  
**Report Generated:** February 9, 2026 09:15 UTC

---

## 🎯 Next Steps

To use this investigation as a template for future incidents:

1. Read [INC-MASTER-PROMPT.md](INC-722-REPORTS/final/INC-MASTER-PROMPT.md)
2. Copy the prompt template
3. Fill in your incident details
4. Deploy agents in parallel
5. Generate verified reports

**Estimated time for future investigations:** 60-90 minutes

---

*Investigation Status: ✅ COMPLETE*
