# API Specification - Waste Sorting Assistant

## Overview
This document defines the API contracts for the Waste Sorting Assistant application, including Firebase services integration, custom endpoints, and third-party API integrations.

## 1. API Architecture

### 1.1 Service Architecture
```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Mobile App    │    │   Firebase      │    │  External APIs  │
│                 │    │   Services      │    │                 │
│  ┌───────────┐  │    │  ┌───────────┐  │    │  ┌───────────┐  │
│  │    UI     │◄─┼────┼─►│  Auth     │  │    │  │  ML Kit   │  │
│  └───────────┘  │    │  └───────────┘  │    │  └───────────┘  │
│  ┌───────────┐  │    │  ┌───────────┐  │    │  ┌───────────┐  │
│  │   Logic   │◄─┼────┼─►│ Firestore │  │    │  │  Vision   │  │
│  └───────────┘  │    │  └───────────┘  │    │  └───────────┘  │
│  ┌───────────┐  │    │  ┌───────────┐  │    │  ┌───────────┐  │
│  │   Data    │◄─┼────┼─►│  Storage  │  │    │  │Analytics  │  │
│  └───────────┘  │    │  └───────────┘  │    │  └───────────┘  │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 2. Authentication API

### 2.1 Firebase Authentication Integration

#### User Registration
```typescript
// Registration Request
POST /auth/register
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "SecurePassword123",
  "displayName": "John Doe",
  "acceptTerms": true
}

// Success Response (201 Created)
{
  "success": true,
  "data": {
    "user": {
      "uid": "firebase_user_id",
      "email": "user@example.com",
      "displayName": "John Doe",
      "emailVerified": false,
      "createdAt": "2024-01-15T10:30:00Z",
      "lastSignInTime": "2024-01-15T10:30:00Z"
    },
    "idToken": "eyJhbGciOiJSUzI1NiIs...",
    "refreshToken": "AMf-vBxYIQ9Q..."
  },
  "message": "Account created successfully. Please verify your email."
}

// Error Response (400 Bad Request)
{
  "success": false,
  "error": {
    "code": "EMAIL_ALREADY_EXISTS",
    "message": "The email address is already in use by another account.",
    "details": {
      "field": "email",
      "value": "user@example.com"
    }
  }
}
```

#### User Login
```typescript
// Login Request
POST /auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "SecurePassword123",
  "rememberMe": true
}

// Success Response (200 OK)
{
  "success": true,
  "data": {
    "user": {
      "uid": "firebase_user_id",
      "email": "user@example.com",
      "displayName": "John Doe",
      "photoURL": "https://example.com/avatar.jpg",
      "emailVerified": true,
      "lastSignInTime": "2024-01-15T10:30:00Z"
    },
    "idToken": "eyJhbGciOiJSUzI1NiIs...",
    "refreshToken": "AMf-vBxYIQ9Q...",
    "expiresIn": 3600
  }
}

// Error Response (401 Unauthorized)
{
  "success": false,
  "error": {
    "code": "INVALID_CREDENTIALS",
    "message": "The email or password is incorrect.",
    "details": {
      "attemptNumber": 3,
      "maxAttempts": 5,
      "lockoutTime": null
    }
  }
}
```

#### Token Refresh
```typescript
// Refresh Token Request
POST /auth/refresh
Content-Type: application/json

{
  "refreshToken": "AMf-vBxYIQ9Q..."
}

// Success Response (200 OK)
{
  "success": true,
  "data": {
    "idToken": "eyJhbGciOiJSUzI1NiIs...",
    "refreshToken": "AMf-vBxYIQ9Q...",
    "expiresIn": 3600
  }
}
```

## 3. User Management API

### 3.1 User Profile Operations

#### Get User Profile
```typescript
// Request
GET /api/v1/users/profile
Authorization: Bearer eyJhbGciOiJSUzI1NiIs...

// Success Response (200 OK)
{
  "success": true,
  "data": {
    "user": {
      "uid": "firebase_user_id",
      "email": "user@example.com",
      "displayName": "John Doe",
      "photoURL": "https://storage.googleapis.com/avatars/user123.jpg",
      "phoneNumber": "+1234567890",
      "emailVerified": true,
      "createdAt": "2024-01-15T10:30:00Z",
      "lastActive": "2024-01-20T14:25:00Z",
      "preferences": {
        "notifications": {
          "scanReminders": true,
          "weeklyStats": true,
          "achievements": true
        },
        "privacy": {
          "shareStats": false,
          "locationServices": true
        },
        "app": {
          "theme": "system",
          "language": "en",
          "units": "metric"
        }
      },
      "statistics": {
        "totalScans": 156,
        "correctScans": 142,
        "accuracyRate": 91.03,
        "co2Saved": 23.4,
        "streakDays": 12
      }
    }
  }
}
```

#### Update User Profile
```typescript
// Request
PATCH /api/v1/users/profile
Authorization: Bearer eyJhbGciOiJSUzI1NiIs...
Content-Type: application/json

{
  "displayName": "John Smith",
  "phoneNumber": "+1234567891",
  "preferences": {
    "notifications": {
      "scanReminders": false
    },
    "app": {
      "theme": "dark"
    }
  }
}

// Success Response (200 OK)
{
  "success": true,
  "data": {
    "user": {
      // Updated user object
    }
  },
  "message": "Profile updated successfully"
}
```

#### Upload Profile Picture
```typescript
// Request
POST /api/v1/users/profile/avatar
Authorization: Bearer eyJhbGciOiJSUzI1NiIs...
Content-Type: multipart/form-data

// Form data:
// avatar: [image file]

// Success Response (200 OK)
{
  "success": true,
  "data": {
    "photoURL": "https://storage.googleapis.com/avatars/user123_updated.jpg",
    "uploadedAt": "2024-01-20T15:30:00Z"
  },
  "message": "Profile picture updated successfully"
}
```

## 4. Waste Scanning API

### 4.1 Image Processing & Recognition

#### Submit Scan Request
```typescript
// Request
POST /api/v1/scans
Authorization: Bearer eyJhbGciOiJSUzI1NiIs...
Content-Type: multipart/form-data

// Form data:
// image: [image file]
// location: '{"latitude": 40.7128, "longitude": -74.0060}' (optional)
// metadata: '{"source": "camera", "timestamp": "2024-01-20T15:30:00Z"}'

// Success Response (200 OK)
{
  "success": true,
  "data": {
    "scanId": "scan_123456789",
    "result": {
      "category": "plastic",
      "subcategory": "bottle",
      "confidence": 0.92,
      "alternatives": [
        {
          "category": "recyclable",
          "subcategory": "container",
          "confidence": 0.78
        }
      ]
    },
    "wasteItem": {
      "id": "plastic_bottle_001",
      "name": "Plastic Bottle",
      "category": "Recyclable",
      "subcategory": "Plastic Container",
      "description": "Single-use plastic bottle, typically used for beverages",
      "sortingInstructions": {
        "binType": "recycling",
        "preparation": [
          "Remove cap and label if possible",
          "Rinse to remove liquid residue",
          "Crush to save space"
        ],
        "restrictions": [
          "Do not include if contaminated with hazardous materials"
        ]
      },
      "environmentalImpact": {
        "co2SavedKg": 2.3,
        "energySavedKwh": 1.2,
        "waterSavedLiters": 15.7,
        "description": "Recycling this bottle saves energy and reduces CO2 emissions"
      },
      "localGuidelines": {
        "accepted": true,
        "specialInstructions": "Check local recycling guidelines for specific requirements",
        "nearestCenter": {
          "name": "Downtown Recycling Center",
          "address": "123 Main St, City, State 12345",
          "distance": 2.3,
          "hours": "Mon-Fri 8AM-6PM, Sat 9AM-3PM"
        }
      }
    },
    "processedAt": "2024-01-20T15:30:15Z",
    "processingTime": 2.3
  }
}

// Error Response (422 Unprocessable Entity)
{
  "success": false,
  "error": {
    "code": "RECOGNITION_FAILED",
    "message": "Unable to identify waste item from the provided image",
    "details": {
      "reason": "low_confidence",
      "suggestions": [
        "Ensure good lighting",
        "Focus on the item clearly",
        "Remove background clutter",
        "Try a different angle"
      ]
    }
  }
}
```

#### Get Scan Details
```typescript
// Request
GET /api/v1/scans/{scanId}
Authorization: Bearer eyJhbGciOiJSUzI1NiIs...

// Success Response (200 OK)
{
  "success": true,
  "data": {
    "scan": {
      "id": "scan_123456789",
      "userId": "firebase_user_id",
      "imageUrl": "https://storage.googleapis.com/scans/scan_123456789.jpg",
      "result": {
        // Same as scan response above
      },
      "wasteItem": {
        // Same as scan response above
      },
      "location": {
        "latitude": 40.7128,
        "longitude": -74.0060,
        "address": "New York, NY, USA"
      },
      "feedback": {
        "isCorrect": true,
        "userCategory": null,
        "comment": null,
        "submittedAt": null
      },
      "createdAt": "2024-01-20T15:30:00Z",
      "updatedAt": "2024-01-20T15:30:15Z"
    }
  }
}
```

### 4.2 Scan History Management

#### Get Scan History
```typescript
// Request
GET /api/v1/users/scans?page=1&limit=20&category=plastic&startDate=2024-01-01&endDate=2024-01-31
Authorization: Bearer eyJhbGciOiJSUzI1NiIs...

// Success Response (200 OK)
{
  "success": true,
  "data": {
    "scans": [
      {
        "id": "scan_123456789",
        "imageUrl": "https://storage.googleapis.com/scans/thumbnails/scan_123456789_thumb.jpg",
        "category": "plastic",
        "subcategory": "bottle",
        "confidence": 0.92,
        "location": {
          "city": "New York",
          "country": "USA"
        },
        "createdAt": "2024-01-20T15:30:00Z",
        "isCorrect": true
      }
      // ... more scans
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 8,
      "totalItems": 156,
      "itemsPerPage": 20,
      "hasNext": true,
      "hasPrev": false
    },
    "statistics": {
      "totalScans": 156,
      "categoryBreakdown": {
        "plastic": 45,
        "paper": 38,
        "organic": 32,
        "metal": 25,
        "glass": 16
      },
      "accuracyRate": 91.03,
      "avgConfidence": 0.87
    }
  }
}
```

#### Delete Scan
```typescript
// Request
DELETE /api/v1/scans/{scanId}
Authorization: Bearer eyJhbGciOiJSUzI1NiIs...

// Success Response (200 OK)
{
  "success": true,
  "message": "Scan deleted successfully"
}
```

### 4.3 Feedback & Learning

#### Submit Scan Feedback
```typescript
// Request
POST /api/v1/scans/{scanId}/feedback
Authorization: Bearer eyJhbGciOiJSUzI1NiIs...
Content-Type: application/json

{
  "isCorrect": false,
  "correctCategory": "organic",
  "correctSubcategory": "food_waste",
  "comment": "This was actually food packaging with food residue",
  "confidence": 5
}

// Success Response (200 OK)
{
  "success": true,
  "message": "Thank you for your feedback! This helps improve our recognition accuracy."
}
```

## 5. Statistics & Analytics API

### 5.1 User Statistics

#### Get User Statistics
```typescript
// Request
GET /api/v1/users/statistics?period=month&startDate=2024-01-01&endDate=2024-01-31
Authorization: Bearer eyJhbGciOiJSUzI1NiIs...

// Success Response (200 OK)
{
  "success": true,
  "data": {
    "period": {
      "startDate": "2024-01-01",
      "endDate": "2024-01-31",
      "type": "month"
    },
    "overview": {
      "totalScans": 45,
      "correctScans": 41,
      "accuracyRate": 91.11,
      "uniqueCategories": 8,
      "streakDays": 12,
      "improvement": {
        "scansVsPrevious": 15.5,
        "accuracyVsPrevious": 2.3
      }
    },
    "environmental": {
      "co2SavedKg": 12.7,
      "energySavedKwh": 8.3,
      "waterSavedLiters": 89.2,
      "treesEquivalent": 0.3,
      "comparison": {
        "avgUser": {
          "co2SavedKg": 8.9,
          "percentile": 78
        }
      }
    },
    "categories": [
      {
        "name": "plastic",
        "count": 15,
        "percentage": 33.3,
        "accuracy": 93.3,
        "co2SavedKg": 5.2
      },
      {
        "name": "paper",
        "count": 12,
        "percentage": 26.7,
        "accuracy": 91.7,
        "co2SavedKg": 3.8
      }
      // ... more categories
    ],
    "trends": {
      "daily": [
        {
          "date": "2024-01-01",
          "scans": 2,
          "accuracy": 100.0
        }
        // ... more daily data
      ],
      "weekly": [
        {
          "week": "2024-W01",
          "scans": 8,
          "accuracy": 87.5
        }
        // ... more weekly data
      ]
    },
    "achievements": [
      {
        "id": "first_scan",
        "name": "First Steps",
        "description": "Complete your first waste scan",
        "unlockedAt": "2024-01-01T10:30:00Z",
        "icon": "🎯"
      }
      // ... more achievements
    ]
  }
}
```

### 5.2 Leaderboards & Community

#### Get Community Statistics
```typescript
// Request
GET /api/v1/community/leaderboard?type=co2_saved&period=month&limit=10
Authorization: Bearer eyJhbGciOiJSUzI1NiIs...

// Success Response (200 OK)
{
  "success": true,
  "data": {
    "leaderboard": [
      {
        "rank": 1,
        "userId": "user_anonymous_1",
        "displayName": "EcoWarrior2024",
        "co2SavedKg": 45.7,
        "totalScans": 189,
        "isCurrentUser": false
      }
      // ... more entries
    ],
    "currentUser": {
      "rank": 23,
      "co2SavedKg": 12.7,
      "totalScans": 45,
      "percentile": 67
    },
    "communityStats": {
      "totalUsers": 1247,
      "totalScans": 23891,
      "totalCo2SavedKg": 2847.3,
      "avgScansPerUser": 19.2
    }
  }
}
```

## 6. Notifications & Preferences API

### 6.1 Notification Management

#### Get Notification Settings
```typescript
// Request
GET /api/v1/users/notifications
Authorization: Bearer eyJhbGciOiJSUzI1NiIs...

// Success Response (200 OK)
{
  "success": true,
  "data": {
    "settings": {
      "pushNotifications": {
        "enabled": true,
        "token": "fcm_token_here",
        "lastUpdated": "2024-01-20T10:30:00Z"
      },
      "preferences": {
        "scanReminders": {
          "enabled": true,
          "frequency": "daily",
          "time": "09:00"
        },
        "weeklyStats": {
          "enabled": true,
          "day": "sunday",
          "time": "18:00"
        },
        "achievements": {
          "enabled": true,
          "immediate": true
        },
        "tips": {
          "enabled": true,
          "frequency": "weekly"
        }
      }
    }
  }
}
```

#### Update Notification Settings
```typescript
// Request
PATCH /api/v1/users/notifications
Authorization: Bearer eyJhbGciOiJSUzI1NiIs...
Content-Type: application/json

{
  "preferences": {
    "scanReminders": {
      "enabled": false
    },
    "weeklyStats": {
      "day": "monday",
      "time": "08:00"
    }
  }
}

// Success Response (200 OK)
{
  "success": true,
  "message": "Notification preferences updated successfully"
}
```

## 7. Error Handling Standards

### 7.1 Standard Error Response Format
```typescript
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable error message",
    "details": {
      // Additional error context
    },
    "timestamp": "2024-01-20T15:30:00Z",
    "requestId": "req_123456789"
  }
}
```

### 7.2 Common Error Codes

| Code | HTTP Status | Description |
|------|-------------|-------------|
| INVALID_REQUEST | 400 | Request validation failed |
| UNAUTHORIZED | 401 | Authentication required |
| FORBIDDEN | 403 | Insufficient permissions |
| NOT_FOUND | 404 | Resource not found |
| VALIDATION_ERROR | 422 | Input validation failed |
| RATE_LIMITED | 429 | Too many requests |
| SERVER_ERROR | 500 | Internal server error |
| SERVICE_UNAVAILABLE | 503 | Service temporarily unavailable |
| RECOGNITION_FAILED | 422 | ML recognition failed |
| IMAGE_TOO_LARGE | 413 | Image exceeds size limit |
| INVALID_IMAGE_FORMAT | 415 | Unsupported image format |

## 8. Rate Limiting & Quotas

### 8.1 Rate Limits

| Endpoint | Limit | Window |
|----------|-------|---------|
| `/auth/*` | 10 requests | per minute |
| `/api/v1/scans` | 50 requests | per hour |
| `/api/v1/users/*` | 100 requests | per hour |
| `/api/v1/statistics` | 30 requests | per hour |

### 8.2 Quota Limits

| Resource | Free Tier | Premium |
|----------|-----------|---------|
| Scans per month | 100 | 1000 |
| Storage (MB) | 50 | 500 |
| API requests/day | 1000 | 10000 |
| History retention | 3 months | 2 years |

## 9. Security Specifications

### 9.1 Authentication Requirements
- All API endpoints require valid Firebase ID token
- Tokens expire after 1 hour, require refresh
- Rate limiting applied per user and IP
- HTTPS required for all communications

### 9.2 Data Validation
```typescript
// Request validation schema example
const scanRequestSchema = {
  image: {
    type: 'file',
    maxSize: '5MB',
    allowedTypes: ['image/jpeg', 'image/png', 'image/webp'],
    required: true
  },
  location: {
    type: 'object',
    properties: {
      latitude: { type: 'number', min: -90, max: 90 },
      longitude: { type: 'number', min: -180, max: 180 }
    },
    required: false
  }
}
```

### 9.3 Privacy & GDPR Compliance
- User consent required for data collection
- Data retention policies enforced
- Right to data portability (export)
- Right to erasure (delete account)
- Data anonymization for analytics

## 10. API Versioning & Backwards Compatibility

### 10.1 Versioning Strategy
- URI path versioning: `/api/v1/`, `/api/v2/`
- Major versions for breaking changes
- Minor versions for backward-compatible additions
- Patch versions for bug fixes only

### 10.2 Deprecation Policy
- 6 months notice for deprecated endpoints
- Migration guides provided
- Gradual rollout of new versions
- Legacy support for critical endpoints

This API specification ensures a robust, scalable, and secure backend for the Waste Sorting Assistant application with clear contracts, comprehensive error handling, and adherence to industry best practices.