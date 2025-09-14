# Operations Runbook - Waste Sorting Assistant

## Document Information
- **Document Version:** 1.0
- **Last Updated:** 2025-09-13
- **Owner:** DevOps Team
- **Next Review:** 2025-10-13

## Table of Contents
1. [System Overview](#system-overview)
2. [Environment Management](#environment-management)
3. [Deployment Procedures](#deployment-procedures)
4. [Monitoring and Alerting](#monitoring-and-alerting)
5. [Incident Response](#incident-response)
6. [Backup and Recovery](#backup-and-recovery)
7. [Performance Management](#performance-management)
8. [Security Operations](#security-operations)
9. [Troubleshooting Guide](#troubleshooting-guide)
10. [Maintenance Procedures](#maintenance-procedures)

## System Overview

### Architecture Summary
```
┌─────────────────────────────────────────────────────────────┐
│                    PRODUCTION ENVIRONMENT                    │
├─────────────────────────────────────────────────────────────┤
│  Flutter Mobile App (Android/iOS)                          │
│  ├─ Authentication: Firebase Auth                          │
│  ├─ Database: Cloud Firestore                              │
│  ├─ Storage: Cloud Storage                                 │
│  ├─ ML: Firebase ML Kit + Custom Models                    │
│  └─ Analytics: Firebase Analytics                          │
├─────────────────────────────────────────────────────────────┤
│  CI/CD Pipeline (GitHub Actions)                           │
│  ├─ Build: Multi-platform builds                          │
│  ├─ Test: Automated testing suite                         │
│  ├─ Security: SAST/DAST scanning                          │
│  └─ Deploy: Automated app store deployment                │
├─────────────────────────────────────────────────────────────┤
│  Infrastructure (Google Cloud Platform)                    │
│  ├─ Compute: Cloud Functions, Cloud Run                   │
│  ├─ Storage: Cloud Storage, Firestore                     │
│  ├─ Networking: Cloud CDN, Load Balancer                  │
│  └─ Security: IAM, VPC, Cloud Armor                       │
└─────────────────────────────────────────────────────────────┘
```

### Key Services
| Service | Purpose | SLA | Owner |
|---------|---------|-----|-------|
| Firebase Auth | User authentication | 99.9% | Google |
| Cloud Firestore | Primary database | 99.95% | Google |
| Cloud Storage | File storage | 99.9% | Google |
| Firebase ML Kit | ML inference | 99.9% | Google |
| Cloud Functions | Backend logic | 99.95% | DevOps |
| GitHub Actions | CI/CD pipeline | 99.95% | DevOps |

## Environment Management

### Environment Hierarchy
```
Production ──── Staging ──── QA ──── Development
    │              │          │           │
    └─ Live       └─ UAT     └─ Test    └─ Feature
       Users         Testing    Builds     Branches
```

### Environment Configuration
**Development Environment:**
- **Purpose:** Feature development and initial testing
- **Firebase Project:** waste-sorting-dev
- **Database:** Firestore (development)
- **Access:** Development team only
- **Data:** Mock/synthetic data only

**QA Environment:**
- **Purpose:** Quality assurance testing
- **Firebase Project:** waste-sorting-qa
- **Database:** Firestore (test data)
- **Access:** QA team and developers
- **Data:** Curated test datasets

**Staging Environment:**
- **Purpose:** Production-like testing and UAT
- **Firebase Project:** waste-sorting-staging
- **Database:** Firestore (production-like data)
- **Access:** QA, product team, stakeholders
- **Data:** Anonymized production data

**Production Environment:**
- **Purpose:** Live user-facing application
- **Firebase Project:** waste-sorting-prod
- **Database:** Firestore (production)
- **Access:** Restricted to operations team
- **Data:** Real user data (privacy compliant)

### Environment Provisioning
**Automated Provisioning:**
```bash
# Create new environment
./scripts/provision-environment.sh --env=staging --region=us-central1

# Configure Firebase project
firebase use waste-sorting-staging
firebase deploy --only firestore:rules,storage:rules

# Set environment variables
firebase functions:config:set app.env=staging
firebase functions:config:set app.ml_model_version=v1.2.0
```

**Manual Configuration:**
1. Create Firebase project through console
2. Enable required APIs (Auth, Firestore, Storage, ML)
3. Configure security rules
4. Set up IAM roles and permissions
5. Configure monitoring and alerting
6. Update CI/CD pipeline environment variables

## Deployment Procedures

### Automated Deployment Pipeline
**Trigger:** Push to main branch or release tag
**Duration:** ~15-20 minutes
**Approval:** Required for production deployments

**Pipeline Stages:**
1. **Build & Test (5 minutes)**
   - Compile Flutter applications
   - Run unit and widget tests
   - Generate code coverage reports

2. **Security Scanning (3 minutes)**
   - SAST analysis with CodeQL
   - Dependency vulnerability scanning
   - Docker image security scanning

3. **Quality Gates (2 minutes)**
   - Code quality analysis
   - Performance benchmarking
   - Test coverage validation

4. **Staging Deployment (3 minutes)**
   - Deploy to staging environment
   - Run integration tests
   - Performance validation

5. **Production Approval (Manual)**
   - Release manager approval required
   - Stakeholder sign-off
   - Change management validation

6. **Production Deployment (5 minutes)**
   - Blue-green deployment strategy
   - Health checks and validation
   - Rollback ready if issues detected

### Manual Deployment Process
**Emergency Hotfix Deployment:**
```bash
# 1. Create hotfix branch
git checkout -b hotfix/critical-security-fix

# 2. Apply fix and test locally
flutter test
flutter build apk --release

# 3. Push to trigger emergency pipeline
git push origin hotfix/critical-security-fix

# 4. Approve production deployment
gh workflow run deploy-production.yml --ref hotfix/critical-security-fix

# 5. Monitor deployment
gh run list --workflow=deploy-production.yml
```

### Rollback Procedures
**Automated Rollback Triggers:**
- Health check failures (>5% error rate)
- Performance degradation (>30% response time increase)
- Critical security alerts
- User-reported critical issues

**Manual Rollback Process:**
```bash
# 1. Identify previous stable version
firebase hosting:versions:list --project=waste-sorting-prod

# 2. Rollback to previous version
firebase hosting:versions:clone <previous-version> --project=waste-sorting-prod

# 3. Verify rollback success
curl -f https://api.wasteassistant.com/health

# 4. Notify stakeholders
./scripts/notify-rollback.sh --reason="Performance degradation"
```

## Monitoring and Alerting

### Monitoring Stack
**Application Performance Monitoring:**
- Firebase Performance Monitoring
- Google Analytics for Firebase
- Custom metrics via Cloud Monitoring
- Real User Monitoring (RUM)

**Infrastructure Monitoring:**
- Google Cloud Monitoring
- Cloud Logging for centralized logs
- Cloud Trace for distributed tracing
- Uptime checks for critical endpoints

**Security Monitoring:**
- Cloud Security Command Center
- Firebase App Check monitoring
- Audit logs monitoring
- Anomaly detection

### Key Performance Indicators (KPIs)
| Metric | Target | Warning | Critical | Alert Channel |
|--------|--------|---------|----------|---------------|
| App Crash Rate | <0.1% | >0.1% | >0.5% | #alerts-critical |
| API Response Time | <500ms | >500ms | >2s | #alerts-performance |
| Authentication Success Rate | >99.5% | <99.5% | <99% | #alerts-auth |
| Database Query Time | <100ms | >100ms | >500ms | #alerts-database |
| Storage Availability | >99.9% | <99.9% | <99.5% | #alerts-storage |
| ML Model Accuracy | >90% | <90% | <85% | #alerts-ml |

### Alerting Configuration
**Alert Policies:**
```yaml
# Critical System Health Alert
alert_policy:
  name: "Critical System Health"
  conditions:
    - error_rate > 5%
    - response_time > 2000ms
    - availability < 99%
  notifications:
    - email: ops-team@wasteassistant.com
    - slack: "#alerts-critical"
    - pagerduty: "primary-on-call"

# Performance Degradation Alert
alert_policy:
  name: "Performance Degradation"
  conditions:
    - response_time > 500ms for 5 minutes
    - memory_usage > 80%
    - cpu_usage > 85%
  notifications:
    - slack: "#alerts-performance"
    - email: performance-team@wasteassistant.com
```

### Dashboard Configuration
**Operations Dashboard:**
- System health overview
- Real-time performance metrics
- Active alerts and incidents
- Deployment status and history

**Business Metrics Dashboard:**
- Daily active users
- Scan success rates
- Feature adoption metrics
- User retention analytics

### Log Management
**Log Aggregation:**
- Centralized logging via Cloud Logging
- Structured JSON format
- Log levels: DEBUG, INFO, WARN, ERROR, FATAL
- Retention: 30 days (standard), 1 year (audit logs)

**Log Analysis:**
```bash
# Search for authentication errors
gcloud logging read "resource.type=cloud_function AND severity=ERROR AND textPayload:auth"

# Monitor API performance
gcloud logging read "resource.type=gae_app AND httpRequest.latency>500ms"

# Security audit trail
gcloud logging read "protoPayload.methodName=SetIamPolicy"
```

## Incident Response

### Incident Classification
| Severity | Definition | Response Time | Examples |
|----------|------------|---------------|----------|
| **P0 - Critical** | Complete service outage | 15 minutes | App completely down, data breach |
| **P1 - High** | Major feature broken | 1 hour | Authentication failing, scanning broken |
| **P2 - Medium** | Minor feature issue | 4 hours | UI glitch, slow performance |
| **P3 - Low** | Cosmetic or documentation | 24 hours | Typo, minor visual issue |

### Incident Response Process
**P0/P1 Incident Response:**
1. **Detection (0-15 minutes)**
   - Automated alert triggers
   - On-call engineer notified
   - Incident commander assigned

2. **Assessment (15-30 minutes)**
   - Impact assessment completed
   - Stakeholder notification
   - War room established if needed

3. **Mitigation (30 minutes - 2 hours)**
   - Immediate workaround applied
   - Root cause investigation begins
   - Regular status updates (every 30 minutes)

4. **Resolution (Variable)**
   - Permanent fix implemented
   - Thorough testing completed
   - Service restored to normal

5. **Post-Mortem (Within 72 hours)**
   - Incident timeline documented
   - Root cause analysis completed
   - Action items identified and assigned

### On-Call Procedures
**On-Call Schedule:**
- Primary on-call: 24/7 coverage
- Secondary on-call: Backup support
- Escalation: Engineering manager
- Rotation: Weekly rotation schedule

**On-Call Responsibilities:**
- Monitor alerts and respond within 15 minutes
- Escalate P0/P1 incidents immediately
- Document all actions taken
- Participate in post-incident reviews

**Escalation Matrix:**
```
P0 Incident → Primary On-Call → Secondary On-Call → Engineering Manager → CTO
     ↓              ↓                 ↓                    ↓             ↓
   15 min         30 min           45 min              60 min        90 min
```

### Communication Templates
**Incident Status Update:**
```
🚨 INCIDENT UPDATE - [Incident ID]
Severity: P1
Status: Investigating
Impact: Authentication failing for ~15% of users
ETA: 30 minutes to resolution
Next Update: 15 minutes

Actions Taken:
- Rolled back to previous deployment
- Investigating database connection issues
- Monitoring error rates

Team: @john-doe (IC), @jane-smith (Dev), @bob-wilson (Product)
```

## Backup and Recovery

### Backup Strategy
**Data Backup Schedule:**
- **Firestore:** Automated daily backups, retained for 30 days
- **Cloud Storage:** Multi-region replication, 99.999999999% durability
- **Configuration:** Weekly backup of Firebase project settings
- **Code:** Git repository with multiple remotes

**Backup Verification:**
- Monthly backup restoration tests
- Quarterly disaster recovery drills
- Annual full system recovery simulation

### Recovery Procedures
**Database Recovery:**
```bash
# List available backups
gcloud firestore backups list --project=waste-sorting-prod

# Restore from specific backup
gcloud firestore restore --source-backup=projects/waste-sorting-prod/locations/us-central1/backups/backup-20250115

# Verify restoration
firebase firestore:indexes
```

**Application Recovery:**
1. **Assess Impact:** Determine scope of data loss
2. **Prepare Environment:** Set up recovery environment
3. **Restore Data:** Apply backup to recovery database
4. **Validate Data:** Run integrity checks
5. **Switch Traffic:** Update DNS to point to recovery
6. **Monitor:** Watch for issues post-recovery

### Business Continuity Plan
**Recovery Time Objective (RTO):** 4 hours
**Recovery Point Objective (RPO):** 1 hour
**Critical Dependencies:**
- Google Cloud Platform
- Firebase services
- GitHub (code repository)
- App stores (for distribution)

## Performance Management

### Performance Monitoring
**Client-Side Metrics:**
- App start time (cold/warm)
- Screen load times
- Image processing duration
- Memory usage patterns
- Battery impact measurements

**Server-Side Metrics:**
- API response times
- Database query performance
- Function execution duration
- Error rates and failures
- Throughput and concurrency

### Performance Optimization
**Regular Performance Reviews:**
- Weekly performance metric analysis
- Monthly optimization sprints
- Quarterly architecture reviews
- Annual capacity planning

**Optimization Strategies:**
- Database query optimization
- Image processing efficiency
- Caching strategy implementation
- CDN utilization optimization
- Code splitting and lazy loading

### Capacity Planning
**Growth Projections:**
- User base: 50% annual growth
- Data storage: 200% annual growth
- API requests: 100% annual growth
- ML model usage: 150% annual growth

**Scaling Triggers:**
- CPU utilization >80% for 15 minutes
- Memory usage >85% consistently
- Database connections >80% of limit
- Storage >90% of allocated space

## Security Operations

### Security Monitoring
**Continuous Monitoring:**
- Authentication anomalies
- Unusual access patterns
- Failed login attempts
- Data access auditing
- Network traffic analysis

**Security Scanning:**
- Daily dependency vulnerability scans
- Weekly infrastructure security scans
- Monthly penetration testing
- Quarterly security assessments

### Security Incident Response
**Security Incident Types:**
- Data breach or unauthorized access
- Authentication system compromise
- Malicious code injection
- DDoS attacks
- Privacy violation

**Response Procedures:**
1. **Immediate Containment:** Isolate affected systems
2. **Assessment:** Determine scope and impact
3. **Notification:** Alert security team and stakeholders
4. **Investigation:** Forensic analysis and evidence collection
5. **Remediation:** Fix vulnerabilities and restore security
6. **Communication:** User notification if required

### Access Management
**Privileged Access:**
- Multi-factor authentication required
- Just-in-time access provisioning
- Regular access reviews (monthly)
- Automated access revocation

**Audit Procedures:**
- Daily access log reviews
- Weekly privilege escalation monitoring
- Monthly comprehensive access audits
- Quarterly access certification process

## Troubleshooting Guide

### Common Issues and Solutions

#### Authentication Issues
**Symptom:** Users unable to log in
**Possible Causes:**
- Firebase Auth service degradation
- Network connectivity issues
- Client-side token expiration
- Account lockout or suspension

**Diagnosis:**
```bash
# Check Firebase Auth status
firebase auth:export users.json --project=waste-sorting-prod

# Monitor authentication metrics
gcloud logging read "resource.type=gae_app AND textPayload:authentication"

# Test authentication endpoint
curl -X POST "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword" \
  -d '{"email":"test@example.com","password":"testpass","returnSecureToken":true}'
```

**Solutions:**
1. Check Firebase service status
2. Restart authentication service
3. Clear client-side cache
4. Verify user account status

#### Scanning Performance Issues
**Symptom:** Slow image processing
**Possible Causes:**
- ML model latency
- Image size/quality issues
- Device performance limitations
- Network connectivity problems

**Diagnosis:**
```bash
# Monitor ML model performance
gcloud logging read "resource.type=cloud_function AND textPayload:ml_processing"

# Check image processing metrics
firebase performance:monitoring
```

**Solutions:**
1. Optimize image preprocessing
2. Update ML model version
3. Implement image compression
4. Add performance monitoring

#### Database Performance Issues
**Symptom:** Slow query responses
**Possible Causes:**
- Missing indexes
- Large document sizes
- Inefficient query patterns
- Database connection limits

**Diagnosis:**
```bash
# Analyze slow queries
gcloud logging read "resource.type=gce_instance AND textPayload:slow_query"

# Check database metrics
gcloud monitoring metrics list --filter="metric.type=firestore.googleapis.com"
```

**Solutions:**
1. Add missing database indexes
2. Optimize query patterns
3. Implement result caching
4. Consider data archiving

### Emergency Procedures
**Complete System Failure:**
1. Activate incident response team
2. Implement backup systems
3. Communicate with users via status page
4. Execute disaster recovery plan
5. Document timeline and actions

**Data Loss Event:**
1. Stop all write operations immediately
2. Assess extent of data loss
3. Restore from most recent backup
4. Validate data integrity
5. Gradual service restoration

## Maintenance Procedures

### Scheduled Maintenance
**Weekly Maintenance (Sundays 2-4 AM UTC):**
- Database maintenance and optimization
- Log rotation and cleanup
- Security patch updates
- Performance metric analysis

**Monthly Maintenance (First Sunday of month):**
- Full system backup verification
- Security vulnerability assessments
- Capacity planning review
- Third-party service updates

**Quarterly Maintenance:**
- Major dependency updates
- Infrastructure security reviews
- Disaster recovery testing
- Performance optimization sprints

### Maintenance Procedures
**Pre-Maintenance Checklist:**
- [ ] Maintenance window scheduled and communicated
- [ ] Backup verification completed
- [ ] Rollback plan prepared
- [ ] Team notification sent
- [ ] Status page updated

**Maintenance Execution:**
- [ ] Systems placed in maintenance mode
- [ ] Changes applied systematically
- [ ] Health checks performed after each step
- [ ] Performance verified
- [ ] Systems returned to normal operation

**Post-Maintenance Checklist:**
- [ ] All systems operational
- [ ] Performance metrics normal
- [ ] No error rate increases
- [ ] Status page updated
- [ ] Team notification sent

### Documentation Updates
**Runbook Maintenance:**
- Monthly procedure reviews
- Quarterly documentation updates
- Annual comprehensive review
- Incident-driven improvements

**Change Log:**
- All procedure changes documented
- Version control for runbook updates
- Regular team training on changes
- Feedback integration process

---

## Emergency Contacts

### Primary Contacts
- **On-Call Engineer:** +1-xxx-xxx-xxxx
- **Engineering Manager:** +1-xxx-xxx-xxxx
- **DevOps Lead:** +1-xxx-xxx-xxxx
- **Security Team:** security@wasteassistant.com

### Vendor Contacts
- **Google Cloud Support:** [Support Case Portal]
- **Firebase Support:** [Firebase Console]
- **GitHub Support:** [GitHub Support]
- **Third-Party Services:** [Contact List]

### Communication Channels
- **Critical Alerts:** #alerts-critical (Slack)
- **Incident Response:** #incident-response (Slack)
- **General Operations:** #ops-team (Slack)
- **Status Updates:** status.wasteassistant.com

---

**Document Control:**
- **Version:** 1.0
- **Last Updated:** 2025-09-13
- **Next Review:** 2025-10-13
- **Owner:** DevOps Team
- **Classification:** Internal Use