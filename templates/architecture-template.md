# Architecture Document

**Project:** [Project Name]
**Version:** 1.0
**Status:** DRAFT | APPROVED
**Date:** [DATE]
**Architect Agent:** v1.0
**Approved by:** [Human Name]

---

## 1. System Overview
> Brief description of the system's architecture and approach.

[Description]

---

## 2. Tech Stack

| Layer | Technology | Rationale |
|---|---|---|
| Frontend | [e.g., React + TypeScript] | [Why] |
| Backend | [e.g., Node.js + Express] | [Why] |
| Database | [e.g., PostgreSQL] | [Why] |
| Auth | [e.g., JWT + OAuth2] | [Why] |
| Cache | [e.g., Redis] | [Why] |
| Deployment | [e.g., AWS ECS] | [Why] |

---

## 3. System Components

```
[ASCII or text diagram of system components and their relationships]

e.g.:
[Client] → [API Gateway] → [Auth Service]
                        → [Feature Service A] → [Database]
                        → [Feature Service B] → [Database]
                                              → [External API]
```

### Component Descriptions

| Component | Responsibility | Technology |
|---|---|---|
| [Name] | [What it does] | [Tech] |

---

## 4. Data Models

### [Entity Name]
| Field | Type | Required | Description |
|---|---|---|---|
| id | UUID | Yes | Primary key |
| [field] | [type] | [Yes/No] | [Description] |

*(add more entities as needed)*

---

## 5. API Contract Index
> All API contracts are defined in `specs/contracts/`. This section provides an index.

| Contract File | Domain | Endpoints |
|---|---|---|
| `specs/contracts/[name].md` | [Domain] | [List of endpoints] |

---

## 6. Authentication & Authorization

| Area | Approach |
|---|---|
| Authentication | [e.g., JWT Bearer tokens, 24h expiry] |
| Authorization | [e.g., RBAC, role definitions] |
| Token refresh | [e.g., Refresh token pattern] |
| Protected routes | [e.g., All /api/* except /api/auth/*] |

---

## 7. Frontend/Backend Parallelization Boundaries

> Defines the contract boundary between parallel agents.

| Concern | Owner |
|---|---|
| UI components, state, routing | Frontend Agent |
| API endpoints, DB, business logic | Backend Agent |
| Auth token handling (client) | Frontend Agent |
| Auth token validation (server) | Backend Agent |
| Shared types / validation schemas | Defined in contracts |

---

## 8. Infrastructure & Deployment

| Environment | Description |
|---|---|
| Development | [Local setup] |
| Staging | [Pre-production environment] |
| Production | [Production environment] |

---

## 9. Security Considerations

- [Consideration 1]
- [Consideration 2]

---

## 10. Trade-offs & Decisions

| Decision | Options Considered | Choice | Rationale |
|---|---|---|---|
| [Decision] | [Option A vs B] | [Choice] | [Why] |

---

## 11. Assumptions
- [ASSUMPTION: Description]

---

## Approval
- [ ] Architecture reviewed by human
- [ ] API contracts reviewed
- [ ] **Human approval granted** — Date: [DATE]
