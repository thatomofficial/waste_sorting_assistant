# Monitoring and Observability Setup

## Document Information
- **Document Version:** 1.0
- **Last Updated:** 2025-09-13
- **Owner:** DevOps & SRE Team
- **Next Review:** 2025-10-13

## Table of Contents
1. [Monitoring Strategy](#monitoring-strategy)
2. [Application Performance Monitoring](#application-performance-monitoring)
3. [Infrastructure Monitoring](#infrastructure-monitoring)
4. [Log Management](#log-management)
5. [Alerting Configuration](#alerting-configuration)
6. [Dashboard Setup](#dashboard-setup)
7. [SLI/SLO Configuration](#slislo-configuration)
8. [Observability Tools](#observability-tools)

## Monitoring Strategy

### Observability Pillars
Our monitoring approach follows the three pillars of observability:

```
┌─────────────────────────────────────────────────────────────┐
│                    METRICS                                  │
│  • Quantitative measurements over time                     │
│  • Performance indicators and KPIs                         │
│  • Resource utilization and business metrics               │
└─────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────┐
│                    LOGS                                     │
│  • Discrete events with context                            │
│  • Error messages and debugging information                │
│  • Audit trails and user interactions                      │
└─────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────┐
│                    TRACES                                   │
│  • Request flow through distributed systems                │
│  • Performance bottleneck identification                   │
│  • Service dependency mapping                              │
└─────────────────────────────────────────────────────────────┘
```

### Monitoring Layers
1. **Business Layer:** User experience and business metrics
2. **Application Layer:** App performance and functionality
3. **Platform Layer:** Firebase and Cloud services
4. **Infrastructure Layer:** Compute, storage, and network

### Golden Signals
We monitor the four golden signals for each service:
- **Latency:** Request response times
- **Traffic:** Request rate and throughput
- **Errors:** Error rates and failure modes
- **Saturation:** Resource utilization levels

## Application Performance Monitoring

### Mobile App Monitoring
**Firebase Performance Monitoring Setup:**
```dart
// lib/main.dart
import 'package:firebase_performance/firebase_performance.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Enable performance monitoring
  FirebasePerformance performance = FirebasePerformance.instance;
  await performance.setPerformanceCollectionEnabled(true);

  runApp(MyApp());
}

// Custom trace for waste classification
class WasteClassificationService {
  Future<ClassificationResult> classifyImage(File image) async {
    final Trace trace = FirebasePerformance.instance.newTrace('image_classification');
    trace.start();

    try {
      // Add custom attributes
      trace.putAttribute('image_size', image.lengthSync().toString());
      trace.putAttribute('model_version', 'v1.2.0');

      final result = await _performClassification(image);

      trace.putAttribute('confidence_score', result.confidence.toString());
      trace.putAttribute('classification', result.category);

      return result;
    } finally {
      trace.stop();
    }
  }
}
```

**Custom Metrics Collection:**
```dart
// lib/utils/analytics_service.dart
class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Track scanning events
  static Future<void> logScanEvent({
    required String wasteType,
    required double confidence,
    required int processingTimeMs,
  }) async {
    await _analytics.logEvent(
      name: 'waste_scan',
      parameters: {
        'waste_type': wasteType,
        'confidence_score': confidence,
        'processing_time_ms': processingTimeMs,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  // Track user retention
  static Future<void> logRetentionEvent(int daysSinceInstall) async {
    await _analytics.logEvent(
      name: 'user_retention',
      parameters: {
        'days_since_install': daysSinceInstall,
        'session_count': await _getSessionCount(),
      },
    );
  }
}
```

### Key Performance Indicators (KPIs)
| Metric | Target | Warning | Critical | Measurement |
|--------|--------|---------|----------|-------------|
| App Start Time (Cold) | <3s | >3s | >5s | 95th percentile |
| App Start Time (Warm) | <1s | >1s | >2s | 95th percentile |
| Crash-Free Users | >99.5% | <99.5% | <99% | 28-day rolling |
| Image Processing Time | <5s | >5s | >10s | 95th percentile |
| Classification Accuracy | >90% | <90% | <85% | Daily average |
| Battery Impact | <5%/hr | >5%/hr | >10%/hr | Device average |

### Performance Monitoring Configuration
**Firebase Performance Rules:**
```javascript
// firebase-performance-rules.js
const performanceConfig = {
  // Automatically capture traces for HTTP requests
  httpRequestTracingEnabled: true,

  // Custom trace sampling rate
  traceSamplingRate: 1.0, // 100% in development, 10% in production

  // Automatic screen traces
  automaticScreenReportingEnabled: true,

  // Data collection settings
  dataCollectionEnabled: true,

  // Performance data export to BigQuery
  exportToBigQuery: true,
};
```

## Infrastructure Monitoring

### Google Cloud Platform Monitoring
**Cloud Monitoring Setup:**
```yaml
# monitoring-config.yaml
alertPolicies:
  - displayName: "High Error Rate"
    combiner: OR
    conditions:
      - displayName: "Error rate > 5%"
        conditionThreshold:
          filter: 'resource.type="cloud_function"'
          comparison: COMPARISON_GT
          thresholdValue: 0.05
          duration: 300s
    notificationChannels:
      - "projects/waste-sorting-prod/notificationChannels/critical-alerts"

  - displayName: "High Memory Usage"
    conditions:
      - displayName: "Memory usage > 80%"
        conditionThreshold:
          filter: 'resource.type="gce_instance" AND metric.type="compute.googleapis.com/instance/memory/utilization"'
          comparison: COMPARISON_GT
          thresholdValue: 0.8
          duration: 600s
```

**Infrastructure Metrics:**
```bash
# Create custom metrics
gcloud logging metrics create slow_requests \
  --description="Requests slower than 1 second" \
  --log-filter='resource.type="cloud_function" AND httpRequest.latency>1s'

# Set up uptime checks
gcloud alpha monitoring uptime create-http \
  --display-name="API Health Check" \
  --hostname=api.wasteassistant.com \
  --path=/health \
  --check-interval=60s \
  --timeout=10s
```

### Firebase Service Monitoring
**Firestore Monitoring:**
```javascript
// Monitor database performance
const firestoreRules = {
  // Monitor document read/write patterns
  match: /databases/{database}/documents/{document=**} {
    allow read, write: if request.time < timestamp.date(2025, 12, 31)
      && logReadWrite(resource, request);
  }
};

function logReadWrite(resource, request) {
  // Custom logging for monitoring
  debug("Firestore Operation: " + request.method +
        " Path: " + request.path +
        " User: " + request.auth.uid);
  return true;
}
```

**Firebase Functions Monitoring:**
```javascript
// functions/index.js
const functions = require('firebase-functions');
const { performance } = require('perf_hooks');

exports.processImage = functions.https.onCall(async (data, context) => {
  const startTime = performance.now();

  try {
    // Function logic here
    const result = await processImageLogic(data);

    // Log performance metrics
    const duration = performance.now() - startTime;
    functions.logger.info('Image processing completed', {
      duration: duration,
      userId: context.auth?.uid,
      imageSize: data.imageSize,
      confidence: result.confidence,
    });

    return result;
  } catch (error) {
    functions.logger.error('Image processing failed', {
      error: error.message,
      userId: context.auth?.uid,
      duration: performance.now() - startTime,
    });
    throw error;
  }
});
```

## Log Management

### Centralized Logging Architecture
```
Mobile Apps ──┐
              ├──► Cloud Logging ──► Log Analysis
Cloud Functions ┘        │            │
                         ├──► BigQuery (Analytics)
                         └──► Log-based Metrics
```

### Structured Logging Standards
**Log Format Specification:**
```json
{
  "timestamp": "2025-01-15T10:30:00.000Z",
  "severity": "INFO",
  "service": "waste-classification",
  "version": "1.2.0",
  "user_id": "user123",
  "session_id": "session456",
  "trace_id": "trace789",
  "message": "Image classification completed",
  "context": {
    "image_size": 1024000,
    "processing_time_ms": 2500,
    "confidence_score": 0.92,
    "waste_category": "recyclable_plastic"
  }
}
```

**Log Level Guidelines:**
- **DEBUG:** Detailed diagnostic information (development only)
- **INFO:** General application flow and business events
- **WARN:** Potentially harmful situations that recovered gracefully
- **ERROR:** Error events that don't stop application execution
- **FATAL:** Severe error events that cause application termination

### Log Aggregation Configuration
**Fluent Bit Configuration:**
```yaml
# fluent-bit.conf
[INPUT]
    Name tail
    Path /var/log/app/*.log
    Parser json
    Tag app.logs
    Refresh_Interval 5

[FILTER]
    Name modify
    Match app.logs
    Add service waste-sorting-assistant
    Add environment production

[OUTPUT]
    Name stackdriver
    Match app.logs
    google_service_credentials /path/to/credentials.json
    resource k8s_container
```

### Log Analysis Queries
**Common Log Analysis Queries:**
```sql
-- Error rate analysis
SELECT
  TIMESTAMP_TRUNC(timestamp, HOUR) as hour,
  COUNT(*) as total_requests,
  COUNTIF(severity = 'ERROR') as error_count,
  COUNTIF(severity = 'ERROR') / COUNT(*) * 100 as error_rate
FROM `project.dataset.logs`
WHERE timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 24 HOUR)
GROUP BY hour
ORDER BY hour;

-- Slow request identification
SELECT
  jsonPayload.context.processing_time_ms as processing_time,
  jsonPayload.user_id,
  jsonPayload.context.image_size,
  timestamp
FROM `project.dataset.logs`
WHERE jsonPayload.context.processing_time_ms > 5000
ORDER BY processing_time DESC
LIMIT 100;
```

## Alerting Configuration

### Alert Policy Framework
**Alert Severity Levels:**
- **P0 - Critical:** Complete service outage, data breach
- **P1 - High:** Major feature broken, performance severely degraded
- **P2 - Medium:** Minor feature issue, performance moderately affected
- **P3 - Low:** Warning condition, planned maintenance needed

### Multi-Channel Alerting
**Notification Channels:**
```yaml
notification_channels:
  - name: "critical-slack"
    type: "slack"
    endpoint: "https://hooks.slack.com/services/xxx/yyy/zzz"

  - name: "pagerduty-primary"
    type: "pagerduty"
    routing_key: "integration-key"

  - name: "ops-email"
    type: "email"
    addresses: ["ops-team@wasteassistant.com"]
```

**Alert Routing Matrix:**
| Severity | Slack | Email | PagerDuty | SMS |
|----------|-------|-------|-----------|-----|
| P0 - Critical | ✅ | ✅ | ✅ | ✅ |
| P1 - High | ✅ | ✅ | ✅ | ❌ |
| P2 - Medium | ✅ | ✅ | ❌ | ❌ |
| P3 - Low | ✅ | ❌ | ❌ | ❌ |

### Smart Alerting Rules
**Alert Suppression:**
```yaml
# Prevent alert fatigue
alerting_rules:
  - name: "error-rate-spike"
    condition: "error_rate > 5% for 5 minutes"
    suppression:
      - during_maintenance_window: true
      - if_related_alert_active: "service-down"
      - max_frequency: "1 per hour"
```

**Alert Escalation:**
```yaml
escalation_policies:
  - name: "critical-escalation"
    steps:
      - delay: "0 minutes"
        targets: ["primary-oncall"]
      - delay: "15 minutes"
        targets: ["secondary-oncall"]
      - delay: "30 minutes"
        targets: ["engineering-manager"]
```

### Automated Response
**Auto-Remediation Scripts:**
```bash
#!/bin/bash
# auto-remediation.sh

case "$ALERT_TYPE" in
  "high-memory-usage")
    # Restart service with higher memory allocation
    gcloud run services update waste-classification \
      --memory=2Gi --region=us-central1
    ;;
  "database-connection-limit")
    # Scale up database connections
    gcloud sql instances patch production-db \
      --database-flags=max_connections=200
    ;;
  "disk-space-low")
    # Clean up old logs
    find /var/log -name "*.log" -mtime +7 -delete
    ;;
esac
```

## Dashboard Setup

### Executive Dashboard
**Business Metrics Overview:**
- Daily Active Users (DAU)
- Monthly Active Users (MAU)
- User Retention Rates
- Scan Success Rate
- Feature Adoption Metrics

**Dashboard Configuration:**
```json
{
  "dashboard": {
    "name": "Executive Overview",
    "widgets": [
      {
        "type": "scorecard",
        "title": "Daily Active Users",
        "query": "metric.type=\"firebase.googleapis.com/analytics/daily_active_users\"",
        "time_range": "24h"
      },
      {
        "type": "xy_chart",
        "title": "Scan Success Rate",
        "query": "metric.type=\"custom.googleapis.com/scan_success_rate\"",
        "time_range": "7d"
      }
    ]
  }
}
```

### Operations Dashboard
**System Health Overview:**
```yaml
operations_dashboard:
  panels:
    - title: "Service Status"
      type: "status_grid"
      services:
        - name: "Mobile App"
          health_check: "/api/health/mobile"
        - name: "API Gateway"
          health_check: "/api/health/gateway"
        - name: "Database"
          health_check: "/api/health/database"

    - title: "Performance Metrics"
      type: "time_series"
      metrics:
        - "response_time_p95"
        - "error_rate"
        - "throughput"

    - title: "Infrastructure Resources"
      type: "gauge"
      metrics:
        - "cpu_utilization"
        - "memory_utilization"
        - "disk_utilization"
```

### Application Performance Dashboard
**Real User Monitoring:**
- Page load times
- User interaction metrics
- Error rates by feature
- Geographic performance distribution

**Synthetic Monitoring:**
- Uptime checks
- API response times
- Feature availability tests
- Cross-region performance

### Security Dashboard
**Security Metrics:**
- Failed authentication attempts
- Unusual access patterns
- Security scan results
- Compliance status indicators

## SLI/SLO Configuration

### Service Level Indicators (SLIs)
**Availability SLI:**
```sql
-- Uptime calculation
SELECT
  COUNT(*) as total_requests,
  COUNTIF(http_status < 500) as successful_requests,
  COUNTIF(http_status < 500) / COUNT(*) * 100 as availability_percentage
FROM http_requests
WHERE timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 24 HOUR);
```

**Latency SLI:**
```sql
-- Response time percentiles
SELECT
  APPROX_QUANTILES(response_time_ms, 100)[OFFSET(50)] as p50,
  APPROX_QUANTILES(response_time_ms, 100)[OFFSET(95)] as p95,
  APPROX_QUANTILES(response_time_ms, 100)[OFFSET(99)] as p99
FROM api_requests
WHERE timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 HOUR);
```

### Service Level Objectives (SLOs)
| Service | SLI | SLO Target | Error Budget | Measurement Window |
|---------|-----|------------|--------------|-------------------|
| API Gateway | Availability | 99.9% | 0.1% (43.2 min/month) | 30 days |
| Database | Availability | 99.95% | 0.05% (21.6 min/month) | 30 days |
| ML Processing | Latency | 95% < 5s | 5% > 5s | 7 days |
| Authentication | Success Rate | 99.5% | 0.5% failures | 30 days |

### Error Budget Monitoring
**Error Budget Calculation:**
```python
def calculate_error_budget(sli_data, slo_target, time_window_hours):
    """Calculate remaining error budget"""
    total_requests = len(sli_data)
    failed_requests = sum(1 for req in sli_data if not req.successful)

    current_sli = (total_requests - failed_requests) / total_requests
    error_rate = 1 - current_sli
    max_error_rate = 1 - slo_target

    error_budget_consumed = error_rate / max_error_rate
    error_budget_remaining = max(0, 1 - error_budget_consumed)

    return {
        'current_sli': current_sli,
        'error_budget_remaining': error_budget_remaining,
        'budget_burn_rate': error_budget_consumed / time_window_hours
    }
```

### SLO-Based Alerting
**Fast Burn Alert (2% budget in 1 hour):**
```yaml
alert:
  name: "SLO Fast Burn - API Availability"
  condition: |
    error_budget_burn_rate > 0.02 AND
    lookback_duration = 1h
  severity: "P1"

alert:
  name: "SLO Slow Burn - API Availability"
  condition: |
    error_budget_burn_rate > 0.005 AND
    lookback_duration = 6h
  severity: "P2"
```

## Observability Tools

### Tool Stack Overview
| Category | Tool | Purpose | Data Retention |
|----------|------|---------|----------------|
| Metrics | Cloud Monitoring | Infrastructure & app metrics | 6 weeks |
| Logs | Cloud Logging | Centralized log aggregation | 30 days |
| Traces | Cloud Trace | Distributed request tracing | 30 days |
| APM | Firebase Performance | Mobile app performance | 60 days |
| Analytics | Firebase Analytics | User behavior & business metrics | 14 months |
| Uptime | Cloud Monitoring | Service availability checks | 6 weeks |

### Integration Configuration
**Observability Pipeline:**
```yaml
# Telemetry data flow
telemetry_pipeline:
  collectors:
    - name: "mobile-app"
      type: "firebase-sdk"
      destinations: ["firebase-analytics", "cloud-monitoring"]

    - name: "backend-services"
      type: "opencensus"
      destinations: ["cloud-monitoring", "cloud-trace"]

    - name: "infrastructure"
      type: "stackdriver-agent"
      destinations: ["cloud-monitoring", "cloud-logging"]

  processors:
    - name: "sampling"
      type: "probabilistic"
      sampling_rate: 0.1

    - name: "enrichment"
      type: "resource-detection"
      detectors: ["gcp", "env"]
```

### Custom Metrics Implementation
**Business Metrics:**
```dart
// Custom business metrics collection
class BusinessMetrics {
  static void trackScanSuccess(String wasteType, double confidence) {
    FirebaseAnalytics.instance.logEvent(
      name: 'scan_success',
      parameters: {
        'waste_type': wasteType,
        'confidence': confidence,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  static void trackUserEngagement(String featureName, int durationSeconds) {
    FirebaseAnalytics.instance.logEvent(
      name: 'feature_engagement',
      parameters: {
        'feature_name': featureName,
        'duration_seconds': durationSeconds,
      },
    );
  }
}
```

### Monitoring Automation
**Automated Monitoring Setup:**
```bash
#!/bin/bash
# setup-monitoring.sh

# Deploy monitoring configuration
terraform apply -var-file=monitoring.tfvars

# Create alert policies
gcloud alpha monitoring policies create --policy-from-file=alert-policies.yaml

# Set up dashboards
gcloud alpha monitoring dashboards create --config-from-file=dashboards.yaml

# Configure notification channels
gcloud alpha monitoring channels create --channel-content-from-file=notifications.yaml

# Deploy custom metrics
kubectl apply -f custom-metrics-config.yaml
```

### Monitoring Best Practices
**Implementation Guidelines:**
1. **Start with the basics:** Golden signals before custom metrics
2. **Monitor user experience:** Focus on user-facing metrics
3. **Alert on symptoms:** Alert on user impact, not just system metrics
4. **Regular review:** Monthly review of alert effectiveness
5. **Documentation:** Keep runbooks updated with monitoring changes

**Performance Optimization:**
- Sample high-volume metrics appropriately
- Use efficient query patterns
- Implement proper data retention policies
- Regular cleanup of unused metrics and dashboards

---

## Monitoring Checklist

### Initial Setup
- [ ] Cloud Monitoring enabled for all projects
- [ ] Firebase Performance SDK integrated in mobile app
- [ ] Structured logging implemented across services
- [ ] Alert policies configured for critical services
- [ ] Dashboards created for key stakeholders
- [ ] SLI/SLO definitions documented and implemented

### Ongoing Maintenance
- [ ] Weekly review of alert effectiveness
- [ ] Monthly SLO performance review
- [ ] Quarterly monitoring tools evaluation
- [ ] Bi-annual monitoring strategy review
- [ ] Regular training on monitoring tools and practices

---

**Document Control:**
- **Version:** 1.0
- **Last Updated:** 2025-09-13
- **Next Review:** 2025-10-13
- **Owner:** DevOps & SRE Team
- **Classification:** Internal Use