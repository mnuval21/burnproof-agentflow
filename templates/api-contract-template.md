# API Contract: [Contract Name]

**Contract ID:** CONTRACT-[N]
**Domain:** [Feature Domain]
**Status:** DRAFT | APPROVED | DEPRECATED
**Version:** 1.0
**Created:** [DATE]
**Last Updated:** [DATE]
**Approved by:** [Human Name]

> ⚠️ This contract is the source of truth for both Frontend (mock) and Backend (implementation). Any deviation must be logged as a drift proposal and approved by the PO Agent and human before implementation.

---

## Base URL
`/api/v1/[domain]`

---

## Authentication
**Required:** Yes / No
**Method:** Bearer token in `Authorization` header

---

## Endpoints

---

### [Verb] [Path]
> [Brief description of what this endpoint does]

**Example:** `POST /api/v1/users/register`

#### Request

**Headers:**
| Header | Value | Required |
|---|---|---|
| Content-Type | application/json | Yes |
| Authorization | Bearer {token} | No/Yes |

**Path Parameters:**
| Parameter | Type | Required | Description |
|---|---|---|---|
| [param] | string | Yes | [Description] |

**Query Parameters:**
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| [param] | string | No | [default] | [Description] |

**Request Body:**
```json
{
  "field1": "string",       // required — [description]
  "field2": 123,            // required — [description]
  "field3": "string"        // optional — [description]
}
```

#### Response

**Success — `200 OK` / `201 Created`**
```json
{
  "field1": "string",
  "field2": 123,
  "nested": {
    "field": "string"
  }
}
```

**Error Responses:**

| Status | Code | Message | When |
|---|---|---|---|
| 400 | `VALIDATION_ERROR` | [message] | [condition] |
| 401 | `UNAUTHORIZED` | [message] | [condition] |
| 403 | `FORBIDDEN` | [message] | [condition] |
| 404 | `NOT_FOUND` | [message] | [condition] |
| 500 | `INTERNAL_ERROR` | [message] | [condition] |

**Error Response Shape:**
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Human-readable description",
    "details": {}
  }
}
```

#### Examples

**curl:**
```bash
curl -X POST https://yourapp.com/api/v1/[path] \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer {token}" \
  -d '{
    "field1": "value",
    "field2": 123
  }'
```

**fetch (TypeScript):**
```typescript
const response = await fetch('/api/v1/[path]', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${token}`,
  },
  body: JSON.stringify({
    field1: 'value',
    field2: 123,
  }),
});
const data = await response.json();
```

---

*(repeat endpoint section for each endpoint in this domain)*

---

## Shared Types

```typescript
// Types used across multiple endpoints in this contract

type [TypeName] = {
  field: string;
}
```

---

## Changelog

| Version | Date | Change | Author |
|---|---|---|---|
| 1.0 | [DATE] | Initial contract | Architect Agent |

---

## Drift Log

*(Entries added when contract deviations are proposed)*

<!--
## Drift Proposal — [DATE]
Proposed by: [Agent]
Change: [What should change]
Reason: [Why]
Impact: [Stories affected]
Status: PENDING_HUMAN_APPROVAL | APPROVED | REJECTED
Resolved: [DATE]
-->
