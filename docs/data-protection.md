# Data Protection Policy — Brookhill

<!-- to be updated with retention periods, need to check with darek -->

**Project:** Brookhill
**Organisation:** Woolwich Service Users Project (WSUP)
**Last updated:** May 2026
**Owner:** Darek Karwacki, WSUP

---

## Overview

Brookhill processes personal data on behalf of WSUP in order to track client interactions, measure service impact, and produce reports for operational and funding purposes. This document outlines how that data is handled, stored, and protected in compliance with UK GDPR and the Data Protection Act 2018.

---

## Data controller

WSUP is the data controller for all personal data processed by Brookhill. The Project Lead acts as data processor during the build phase and is bound by the terms of the project IP agreement.

---

## What data we process

| Data type | Source | Purpose |
|---|---|---|
| Client name | Plinth API / intake form | Identifying individuals across sessions |
| Session attendance | Plinth API | Tracking engagement over time |
| Services accessed | Plinth API / intake form | Understanding service utilisation |
| Wellbeing score | Intake form | Measuring client outcomes over time |
| Booking history | Plinth API | Cross-session analysis and reporting |

No special category data (health, ethnicity, religion etc) is processed by Brookhill unless explicitly agreed and documented here.

---

## Data storage

- All personal data is stored in Supabase, hosted in the **EU (West Europe) region**
- No personal data is stored in this GitHub repository
- No personal data is stored in Google Data Studio — it queries Supabase directly and does not copy or cache data
- Credentials and API keys are stored in GitHub Secrets and Bitwarden — never in code or documents

---

## Data retention

| Data type | Retention period | Basis |
|---|---|---|
| Client records | [To be confirmed with CEO] | Legitimate interest — impact measurement |
| Session attendance | [To be confirmed with CEO] | Legitimate interest — service delivery |
| Form responses | [To be confirmed with CEO] | Legitimate interest — impact measurement |

Retention periods to be agreed with the CEO and updated here before go-live.

---

## Access control

| Role | Access level |
|---|---|
| Project Lead | Full access during build — read/write to Supabase, GitHub Secrets |
| Developer (Jonathan) | Read/write to Supabase during build — credentials via Bitwarden |
| WSUP staff | Read-only access via Google Data Studio dashboards |
| CEO | Full access post-handover |

Access is reviewed and revoked for any contributor who leaves the project.

---

## Data subject rights

Under UK GDPR, individuals have the right to:
- Access their personal data
- Request correction of inaccurate data
- Request deletion of their data
- Object to processing

Requests should be directed to WSUP's nominated data lead. The Project Lead will assist with any technical aspects of fulfilling requests (e.g. locating and deleting a record from Supabase).

---

## Breach procedure

In the event of a suspected data breach:

1. Project Lead notifies WSUP CEO immediately
2. WSUP assesses whether the breach must be reported to the ICO within 72 hours
3. Affected individuals are notified if required
4. Incident is documented

---

## Notes

- [ ] Retention periods to be confirmed with CEO before go-live
- [ ] WSUP data protection registration with ICO to be confirmed
- [ ] Named data lead at WSUP to be confirmed
