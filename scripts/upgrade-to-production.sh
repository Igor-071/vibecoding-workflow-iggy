#!/bin/bash

# =============================================================================
# Vibecoding Workflow - Upgrade Prototype to Production
# =============================================================================
#
# Run this script when you're ready to move from prototype to production.
# This will:
#   1. Update the approach setting
#   2. Enable all 10 quality gates
#   3. Optionally set up backend
#   4. Create a transition checklist
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Upgrade: PROTOTYPE → PRODUCTION                        ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# -----------------------------------------------------------------------------
# Check current approach
# -----------------------------------------------------------------------------
CURRENT_APPROACH=$(grep "^approach:" config/workflow.config.yaml | sed 's/approach: "\(.*\)"/\1/' | tr -d ' ')

if [ "$CURRENT_APPROACH" = "production" ]; then
    echo -e "${YELLOW}This project is already in PRODUCTION mode.${NC}"
    exit 0
fi

echo -e "${YELLOW}Current mode: PROTOTYPE${NC}"
echo ""

# -----------------------------------------------------------------------------
# Confirmation
# -----------------------------------------------------------------------------
echo -e "${YELLOW}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${YELLOW}║  What changes when upgrading to PRODUCTION?               ║${NC}"
echo -e "${YELLOW}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "  Quality Gates: 5 → 10 (adding Performance, Accessibility,"
echo "                         Browser Testing, Integration, Security)"
echo ""
echo "  Backend:       Optional setup for real APIs and database"
echo ""
echo "  Rigor:         Full specs, complete test coverage,"
echo "                 stricter quality requirements"
echo ""
read -p "Are you ready to upgrade to PRODUCTION mode? (y/n): " CONFIRM

if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo -e "${YELLOW}Upgrade cancelled.${NC}"
    exit 0
fi

echo ""

# -----------------------------------------------------------------------------
# Backend Setup (optional)
# -----------------------------------------------------------------------------
echo -e "${YELLOW}Step 1: Backend Setup${NC}"
echo ""
echo "Do you want to add a backend now?"
echo "  1) Yes - Set up backend framework and database"
echo "  2) No  - Keep frontend-only for now (can add later)"
read -p "Select (1-2): " BACKEND_CHOICE

BACKEND_FRAMEWORK="null"
DATABASE="null"

if [ "$BACKEND_CHOICE" = "1" ]; then
    echo ""
    echo "Select backend framework:"
    echo "  1) node      - Node.js (Express/Fastify)"
    echo "  2) python    - Python (FastAPI/Django)"
    echo "  3) go        - Go"
    echo "  4) rust      - Rust"
    read -p "Select (1-4): " BE_CHOICE

    case $BE_CHOICE in
        1) BACKEND_FRAMEWORK="node" ;;
        2) BACKEND_FRAMEWORK="python" ;;
        3) BACKEND_FRAMEWORK="go" ;;
        4) BACKEND_FRAMEWORK="rust" ;;
        *) BACKEND_FRAMEWORK="node" ;;
    esac

    echo ""
    echo "Select database:"
    echo "  1) supabase   - Supabase (Postgres + Auth + Storage)"
    echo "  2) postgres   - PostgreSQL"
    echo "  3) mongodb    - MongoDB"
    echo "  4) firebase   - Firebase"
    echo "  5) none       - No database yet"
    read -p "Select (1-5): " DB_CHOICE

    case $DB_CHOICE in
        1) DATABASE="supabase" ;;
        2) DATABASE="postgres" ;;
        3) DATABASE="mongodb" ;;
        4) DATABASE="firebase" ;;
        5) DATABASE="null" ;;
        *) DATABASE="null" ;;
    esac

    echo -e "${GREEN}✓ Backend: $BACKEND_FRAMEWORK${NC}"
    echo -e "${GREEN}✓ Database: $DATABASE${NC}"
fi

echo ""

# -----------------------------------------------------------------------------
# Update Configuration
# -----------------------------------------------------------------------------
echo -e "${YELLOW}Step 2: Updating configuration...${NC}"

if [ -f "config/workflow.config.yaml" ]; then
    # Update approach
    sed -i.bak 's/approach: "prototype"/approach: "production"/g' config/workflow.config.yaml

    # Update backend if selected
    if [ "$BACKEND_FRAMEWORK" != "null" ]; then
        sed -i.bak "s/framework: null.*# node | python/framework: \"$BACKEND_FRAMEWORK\"                         # node | python/g" config/workflow.config.yaml
    fi

    if [ "$DATABASE" != "null" ]; then
        sed -i.bak "s/database: null.*# postgres | mongodb/database: \"$DATABASE\"                          # postgres | mongodb/g" config/workflow.config.yaml
    fi

    rm -f config/workflow.config.yaml.bak
    echo -e "${GREEN}✓ Updated config/workflow.config.yaml${NC}"
fi

# Update CLAUDE.md
if [ -f "CLAUDE.md" ]; then
    sed -i.bak 's/\[APPROACH\]/production/g' CLAUDE.md
    rm -f CLAUDE.md.bak
    echo -e "${GREEN}✓ Updated CLAUDE.md${NC}"
fi

# -----------------------------------------------------------------------------
# Create Transition Checklist
# -----------------------------------------------------------------------------
echo ""
echo -e "${YELLOW}Step 3: Creating transition checklist...${NC}"

CHECKLIST_FILE="docs/specs/PRODUCTION-UPGRADE-CHECKLIST.md"
cat > "$CHECKLIST_FILE" << 'EOF'
# Production Upgrade Checklist

This checklist tracks the transition from PROTOTYPE to PRODUCTION mode.

## Pre-Upgrade Review

- [ ] Prototype has been validated with users/stakeholders
- [ ] Core features are working correctly
- [ ] Decision made: Upgrade existing code OR rebuild from scratch

## Quality Gate Readiness

### New Gates to Address

These gates were skipped in prototype mode and now need attention:

#### Performance
- [ ] Run Lighthouse audit
- [ ] Optimize images (WebP, lazy loading)
- [ ] Implement code splitting
- [ ] Target: Lighthouse > 90, FCP < 1.5s

#### Accessibility
- [ ] Add keyboard navigation
- [ ] Add ARIA labels where needed
- [ ] Test with screen reader
- [ ] Check color contrast
- [ ] Target: WCAG 2.1 AA compliance

#### Browser Testing
- [ ] Test in Chrome
- [ ] Test in Safari
- [ ] Test in Firefox
- [ ] Test in Chrome Mobile
- [ ] Test in Safari Mobile

#### Integration
- [ ] Set up real API endpoints
- [ ] Implement proper error handling
- [ ] Add loading states
- [ ] Handle network failures gracefully

#### Security
- [ ] Move secrets to environment variables
- [ ] Sanitize all user inputs
- [ ] Implement CSRF protection (if applicable)
- [ ] Add rate limiting (if applicable)
- [ ] Security audit of authentication flow

## Backend Setup (if applicable)

- [ ] Set up database schema
- [ ] Create API endpoints
- [ ] Implement authentication
- [ ] Set up environment variables
- [ ] Configure CI/CD for backend

## Code Quality Improvements

- [ ] Review and improve test coverage
- [ ] Add integration tests
- [ ] Remove any hardcoded mock data
- [ ] Clean up console.logs
- [ ] Add proper error boundaries

## Documentation

- [ ] Update all feature specs for production requirements
- [ ] Document API endpoints
- [ ] Update deployment documentation
- [ ] Create runbook for common issues

## Sign-off

| Role | Name | Date | Approved |
|------|------|------|----------|
| Product Owner | | | [ ] |
| Tech Lead | | | [ ] |
| Quality Lead | | | [ ] |
EOF

echo -e "${GREEN}✓ Created $CHECKLIST_FILE${NC}"

# -----------------------------------------------------------------------------
# Summary
# -----------------------------------------------------------------------------
echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║              Upgrade Complete!                             ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}Mode: PRODUCTION${NC}"
[ "$BACKEND_FRAMEWORK" != "null" ] && echo -e "${GREEN}Backend: $BACKEND_FRAMEWORK${NC}"
[ "$DATABASE" != "null" ] && echo -e "${GREEN}Database: $DATABASE${NC}"
echo ""
echo -e "${YELLOW}PRODUCTION MODE - All 10 Quality Gates Now Required:${NC}"
echo "  ✓ Code Quality"
echo "  ✓ Functionality"
echo "  ✓ Mobile Responsive"
echo "  ✓ UX Consistency"
echo "  ✓ Documentation"
echo -e "  ${BLUE}+ Performance${NC} (NEW)"
echo -e "  ${BLUE}+ Accessibility${NC} (NEW)"
echo -e "  ${BLUE}+ Browser Testing${NC} (NEW)"
echo -e "  ${BLUE}+ Integration${NC} (NEW)"
echo -e "  ${BLUE}+ Security${NC} (NEW)"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Review the transition checklist: $CHECKLIST_FILE"
echo "  2. Address each new quality gate"
echo "  3. Set up backend if needed"
echo "  4. Update existing feature specs with production requirements"
echo ""
echo -e "${GREEN}Good luck with production!${NC}"
