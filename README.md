# Brookhill

Data management and reporting solution for the **Woolwich Service Users Project (WSUP)** — a community charity based in Woolwich, London.

Built and maintained by volunteer data engineers as a pro bono project.

---

## What is Brookhill?

WSUP runs community sessions helping local service users access support. Brookhill replaces a manual data process with an automated pipeline that:

- Pulls client, session, and interaction data from the Plinth API
- Stores it in a structured database
- Produces reports, dashboards, and per-person history that anyone can use — no technical knowledge required

---

## Architecture

```
Plinth API ──▶ Python ingestion script ──▶ Supabase (Postgres) ──▶ Google Data Studio
                    (GitHub Actions)                                  Pre-built queries
                                                                      Client lookup
```

| Layer | Tool | Purpose |
|---|---|---|
| Data source | Plinth API | Client records, sessions, bookings, survey responses |
| Scheduling | GitHub Actions | Triggers ingestion on a cron schedule |
| Processing | Python | Fetch, validate, deduplicate, version tag |
| Storage | Supabase (Postgres) | Structured database, EU-hosted |
| Reporting | Google Data Studio | Dashboards, client lookup, pre-built queries |
| Monitoring | Microsoft Teams | Pipeline success / failure alerts |
| Uptime | UptimeRobot | Keepalive ping to prevent Supabase free tier pausing |

---

## Repository Structure

```
brookhill/
├── ingestion/
│   ├── extract.py          # Plinth API fetching logic
│   ├── transform.py        # Validation and deduplication
│   ├── load.py             # Supabase insert logic
│   └── ingest.py           # Main entry point, orchestrates ETL
├── migration/              # One-off historical data migration script
├── schema/                 # Supabase database schema and migration files
├── queries/                # Pre-built SQL queries for Data Studio and reporting
├── .github/
│   └── workflows/          # GitHub Actions cron jobs and CI
├── docs/                   # Project documentation
├── .env.example            # Environment variable template (never commit .env)
├── .python-version         # Pins Python to 3.11.9
├── requirements.txt
├── LICENSE
├── CONTIRBUTING.md
└── README.md

```

---

## Getting Started

### Prerequisites

- Python 3.11.9 (see `.python-version`)
- A Supabase project (EU region)
- A Plinth API key (`sk_...`) with org admin access
- Credentials from the Project Lead via Bitwarden

### Environment variables

Copy `.env.example` to `.env` and fill in values from Bitwarden. Never commit `.env`.

```bash
cp .env.example .env
```

| Variable | Description |
|---|---|
| `PLINTH_API_KEY` | Plinth API key (`sk_...`) |
| `SUPABASE_URL` | Your Supabase project URL |
| `SUPABASE_KEY` | Supabase service role key |
| `TEAMS_WEBHOOK_URL` | Microsoft Teams incoming webhook for alerts |

In production, these are stored as **GitHub Secrets** — never in code.

### Running the ingestion script locally

```bash
pip install -r requirements.txt
cd ingestion
python ingest.py
```

---

## Data & Privacy

- All data is scoped to WSUP's Plinth organisation
- Supabase is hosted in the EU (GDPR compliant region)
- No personal data is stored in this repository
- API keys and credentials are stored exclusively in GitHub Secrets and Bitwarden
---

## Project Team

| Role | Name |
|---|---|
| Project Lead | [Your Name] |
| Developer | Jonathan [Last Name] |

---

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) before making any changes.

---

## License

Copyright (c) 2026 Woolwich Service Users Project (WSUP). Licensed under the [MIT License](LICENSE).

---

## Support

For technical issues during the project, open a GitHub Issue. For urgent problems, contact the Project Lead.
