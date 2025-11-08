# API Documentation

This section contains comprehensive documentation for all API endpoints, data structures, and integration points for the Dofus Tools application.

## Overview

The Dofus Tools API provides a RESTful interface for accessing tool functionality, managing data, and interacting with the application backend.

**API Base URL**: `https://api.dofus-tools.com/v1/` (staging/production)

## Table of Contents

1. [Authentication](#authentication)
2. [Endpoints](#endpoints)
3. [Data Structures](#data-structures)
4. [Error Handling](#error-handling)
5. [Rate Limiting](#rate-limiting)

## Authentication

### JWT Bearer Token

All API requests require authentication via JWT bearer token included in the Authorization header:

```
Authorization: Bearer <your_jwt_token>
```

### Obtaining a Token

```http
POST /api/v1/auth/login
Content-Type: application/json

{
  "username": "user@example.com",
  "password": "password"
}
```

**Response**:
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "Bearer",
  "expires_in": 3600
}
```

## Endpoints

### Tools Endpoints

#### Get All Tools
```http
GET /api/v1/tools
Authorization: Bearer <token>
```

**Response** (200 OK):
```json
{
  "data": [
    {
      "id": "tool-001",
      "name": "Tool Name",
      "description": "Description of the tool",
      "category": "category",
      "version": "1.0.0"
    }
  ],
  "total": 1,
  "page": 1,
  "page_size": 20
}
```

#### Get Tool by ID
```http
GET /api/v1/tools/{id}
Authorization: Bearer <token>
```

**Response** (200 OK):
```json
{
  "id": "tool-001",
  "name": "Tool Name",
  "description": "Description of the tool",
  "category": "category",
  "version": "1.0.0",
  "created_at": "2025-01-01T00:00:00Z",
  "updated_at": "2025-01-02T00:00:00Z"
}
```

## Data Structures

### Tool Object

| Field | Type | Description |
|-------|------|-------------|
| id | string | Unique identifier |
| name | string | Tool name |
| description | string | Tool description |
| category | string | Tool category |
| version | string | Version number (semver) |
| created_at | ISO 8601 | Creation timestamp |
| updated_at | ISO 8601 | Last update timestamp |

## Error Handling

All API errors return appropriate HTTP status codes with error details:

```json
{
  "error": {
    "code": "INVALID_REQUEST",
    "message": "Human-readable error message",
    "details": {}
  }
}
```

### Common Error Codes

| Code | HTTP Status | Description |
|------|-------------|-------------|
| UNAUTHORIZED | 401 | Invalid or missing authentication |
| FORBIDDEN | 403 | User does not have permission |
| NOT_FOUND | 404 | Resource does not exist |
| INVALID_REQUEST | 400 | Invalid request parameters |
| SERVER_ERROR | 500 | Internal server error |

## Rate Limiting

API requests are rate-limited to prevent abuse:

- **Default**: 1,000 requests per hour per user
- **Premium**: 10,000 requests per hour per user

Rate limit information is included in response headers:

```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1640000000
```

## Pagination

List endpoints support pagination through query parameters:

```http
GET /api/v1/tools?page=2&page_size=50
```

**Parameters**:
- `page`: Page number (default: 1)
- `page_size`: Results per page (default: 20, max: 100)

## Examples

### Using curl

```bash
# Get authentication token
curl -X POST https://api.dofus-tools.com/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"user@example.com","password":"password"}'

# Get all tools
curl -X GET https://api.dofus-tools.com/v1/tools \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### Using JavaScript (Fetch API)

```javascript
// Authenticate
const response = await fetch('https://api.dofus-tools.com/v1/auth/login', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    username: 'user@example.com',
    password: 'password'
  })
});

const { access_token } = await response.json();

// Get tools
const toolsResponse = await fetch('https://api.dofus-tools.com/v1/tools', {
  headers: { 'Authorization': `Bearer ${access_token}` }
});

const tools = await toolsResponse.json();
```

---

**Document Status**: Template - To be completed during migration
**Last Updated**: November 8, 2025
