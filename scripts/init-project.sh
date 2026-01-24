#!/bin/bash

# =============================================================================
# Vibecoding Workflow - Project Initialization Script
# =============================================================================
#
# This script helps you configure the workflow template for your project.
# Run it after cloning the template: ./scripts/init-project.sh
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
echo -e "${BLUE}║     Vibecoding Workflow - Project Initialization          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# -----------------------------------------------------------------------------
# FIRST DECISION: Prototype or Production?
# -----------------------------------------------------------------------------
echo -e "${YELLOW}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${YELLOW}║  STEP 1: What are you building?                           ║${NC}"
echo -e "${YELLOW}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  ${GREEN}1) PROTOTYPE${NC} - Frontend-only, fast iteration"
echo "     • Focus on UI/UX and visual feedback"
echo "     • 5 essential quality gates only"
echo "     • Mock data / local storage"
echo "     • Good for: MVPs, demos, concept validation"
echo ""
echo -e "  ${BLUE}2) PRODUCTION${NC} - Full-stack, maximum rigor"
echo "     • Complete backend integration"
echo "     • All 10 quality gates required"
echo "     • Full test coverage"
echo "     • Good for: Production apps, client deliverables"
echo ""
read -p "Select approach (1-2): " APPROACH_CHOICE

case $APPROACH_CHOICE in
    1)
        APPROACH="prototype"
        echo -e "${GREEN}✓ Building a PROTOTYPE (frontend-only focus)${NC}"
        ;;
    2)
        APPROACH="production"
        echo -e "${GREEN}✓ Building for PRODUCTION (full rigor)${NC}"
        ;;
    *)
        APPROACH="prototype"
        echo -e "${YELLOW}Defaulting to PROTOTYPE mode${NC}"
        ;;
esac
echo ""

# -----------------------------------------------------------------------------
# Project Name
# -----------------------------------------------------------------------------
echo -e "${YELLOW}Step 2: Project Name${NC}"
read -p "Enter your project name: " PROJECT_NAME

if [ -z "$PROJECT_NAME" ]; then
    echo -e "${RED}Error: Project name cannot be empty${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Project name: $PROJECT_NAME${NC}"
echo ""

# -----------------------------------------------------------------------------
# Project Type
# -----------------------------------------------------------------------------
echo -e "${YELLOW}Step 3: Project Type${NC}"
echo "  1) web       - Web application (React, Vue, etc.)"
echo "  2) mobile    - Mobile application"
echo "  3) backend   - Backend service / API"
echo "  4) fullstack - Full-stack application"
echo "  5) cli       - Command-line tool"
read -p "Select project type (1-5): " TYPE_CHOICE

case $TYPE_CHOICE in
    1) PROJECT_TYPE="web" ;;
    2) PROJECT_TYPE="mobile" ;;
    3) PROJECT_TYPE="backend" ;;
    4) PROJECT_TYPE="fullstack" ;;
    5) PROJECT_TYPE="cli" ;;
    *) echo -e "${RED}Invalid choice${NC}"; exit 1 ;;
esac

echo -e "${GREEN}✓ Project type: $PROJECT_TYPE${NC}"
echo ""

# -----------------------------------------------------------------------------
# Frontend Framework (if applicable)
# -----------------------------------------------------------------------------
FRONTEND_FRAMEWORK="null"
if [ "$PROJECT_TYPE" = "web" ] || [ "$PROJECT_TYPE" = "mobile" ] || [ "$PROJECT_TYPE" = "fullstack" ]; then
    echo -e "${YELLOW}Step 4: Frontend Framework${NC}"
    echo "  1) react     - React"
    echo "  2) vue       - Vue.js"
    echo "  3) svelte    - Svelte"
    echo "  4) angular   - Angular"
    echo "  5) vanilla   - Vanilla JS"
    echo "  6) none      - No frontend"
    read -p "Select frontend framework (1-6): " FE_CHOICE

    case $FE_CHOICE in
        1) FRONTEND_FRAMEWORK="react" ;;
        2) FRONTEND_FRAMEWORK="vue" ;;
        3) FRONTEND_FRAMEWORK="svelte" ;;
        4) FRONTEND_FRAMEWORK="angular" ;;
        5) FRONTEND_FRAMEWORK="vanilla" ;;
        6) FRONTEND_FRAMEWORK="null" ;;
        *) FRONTEND_FRAMEWORK="react" ;;
    esac

    echo -e "${GREEN}✓ Frontend: $FRONTEND_FRAMEWORK${NC}"
    echo ""
fi

# -----------------------------------------------------------------------------
# Backend Framework (if applicable)
# -----------------------------------------------------------------------------
# For prototype mode, skip backend by default
BACKEND_FRAMEWORK="null"
if [ "$APPROACH" = "production" ]; then
    if [ "$PROJECT_TYPE" = "backend" ] || [ "$PROJECT_TYPE" = "fullstack" ] || [ "$PROJECT_TYPE" = "cli" ]; then
        echo -e "${YELLOW}Step 5: Backend/Language${NC}"
    echo "  1) node      - Node.js"
    echo "  2) python    - Python"
    echo "  3) go        - Go"
    echo "  4) rust      - Rust"
    echo "  5) none      - No backend"
    read -p "Select backend (1-5): " BE_CHOICE

    case $BE_CHOICE in
        1) BACKEND_FRAMEWORK="node" ;;
        2) BACKEND_FRAMEWORK="python" ;;
        3) BACKEND_FRAMEWORK="go" ;;
        4) BACKEND_FRAMEWORK="rust" ;;
        5) BACKEND_FRAMEWORK="null" ;;
        *) BACKEND_FRAMEWORK="node" ;;
    esac

        echo -e "${GREEN}✓ Backend: $BACKEND_FRAMEWORK${NC}"
        echo ""
    fi
elif [ "$APPROACH" = "prototype" ]; then
    echo -e "${YELLOW}Skipping backend setup (Prototype mode = frontend-only)${NC}"
    echo ""
fi

# -----------------------------------------------------------------------------
# Update Configuration Files
# -----------------------------------------------------------------------------
echo -e "${YELLOW}Updating configuration files...${NC}"

# Update workflow.config.yaml
if [ -f "config/workflow.config.yaml" ]; then
    # Update approach
    sed -i.bak "s/approach: \"prototype\"/approach: \"$APPROACH\"/g" config/workflow.config.yaml

    # Update project settings
    sed -i.bak "s/\[PROJECT_NAME\]/$PROJECT_NAME/g" config/workflow.config.yaml
    sed -i.bak "s/type: \"web\"/type: \"$PROJECT_TYPE\"/g" config/workflow.config.yaml

    # Update frontend framework
    if [ "$FRONTEND_FRAMEWORK" != "null" ]; then
        sed -i.bak "s/framework: \"react\"/framework: \"$FRONTEND_FRAMEWORK\"/g" config/workflow.config.yaml
    fi

    # Disable mobile gates for non-web projects
    if [ "$PROJECT_TYPE" = "backend" ] || [ "$PROJECT_TYPE" = "cli" ]; then
        sed -i.bak "s/mobile_responsive:/mobile_responsive:\n    enabled: false/g" config/workflow.config.yaml
        sed -i.bak "s/accessibility:/accessibility:\n    enabled: false/g" config/workflow.config.yaml
        sed -i.bak "s/browser_testing:/browser_testing:\n    enabled: false/g" config/workflow.config.yaml
        sed -i.bak "s/ux_consistency:/ux_consistency:\n    enabled: false/g" config/workflow.config.yaml
        sed -i.bak "s/mobile_first:/mobile_first:\n  enabled: false/g" config/workflow.config.yaml
    fi

    rm -f config/workflow.config.yaml.bak
    echo -e "${GREEN}✓ Updated config/workflow.config.yaml${NC}"
fi

# Update CLAUDE.md
if [ -f "CLAUDE.md" ]; then
    sed -i.bak "s/\[PROJECT_NAME\]/$PROJECT_NAME/g" CLAUDE.md
    sed -i.bak "s/\[web | mobile | backend | fullstack | cli\]/$PROJECT_TYPE/g" CLAUDE.md

    TECH_STACK=""
    if [ "$FRONTEND_FRAMEWORK" != "null" ]; then
        TECH_STACK="$FRONTEND_FRAMEWORK"
    fi
    if [ "$BACKEND_FRAMEWORK" != "null" ]; then
        if [ -n "$TECH_STACK" ]; then
            TECH_STACK="$TECH_STACK + $BACKEND_FRAMEWORK"
        else
            TECH_STACK="$BACKEND_FRAMEWORK"
        fi
    fi
    sed -i.bak "s/\[TECH_STACK\]/$TECH_STACK/g" CLAUDE.md

    rm -f CLAUDE.md.bak
    echo -e "${GREEN}✓ Updated CLAUDE.md${NC}"
fi

# Update GitHub issue template config
if [ -f ".github/ISSUE_TEMPLATE/config.yml" ]; then
    # Get git remote URL to extract owner/repo
    REMOTE_URL=$(git config --get remote.origin.url 2>/dev/null || echo "")
    if [ -n "$REMOTE_URL" ]; then
        # Extract owner/repo from URL
        REPO_PATH=$(echo "$REMOTE_URL" | sed -E 's/.*github\.com[:/](.+)(\.git)?$/\1/' | sed 's/\.git$//')
        sed -i.bak "s|\[OWNER\]/\[REPO\]|$REPO_PATH|g" .github/ISSUE_TEMPLATE/config.yml
        rm -f .github/ISSUE_TEMPLATE/config.yml.bak
        echo -e "${GREEN}✓ Updated .github/ISSUE_TEMPLATE/config.yml${NC}"
    fi
fi

# -----------------------------------------------------------------------------
# Rename CI Workflow
# -----------------------------------------------------------------------------
echo ""
echo -e "${YELLOW}Setting up CI workflow...${NC}"
if [ -f ".github/workflows/quality-check.yml.example" ]; then
    cp .github/workflows/quality-check.yml.example .github/workflows/quality-check.yml
    echo -e "${GREEN}✓ Created .github/workflows/quality-check.yml${NC}"
    echo -e "${YELLOW}  Note: Edit this file to add your actual build/test commands${NC}"
fi

# -----------------------------------------------------------------------------
# Summary
# -----------------------------------------------------------------------------
echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                    Setup Complete!                         ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}Project: $PROJECT_NAME${NC}"
if [ "$APPROACH" = "prototype" ]; then
    echo -e "${GREEN}Approach: PROTOTYPE (frontend-only, 5 quality gates)${NC}"
else
    echo -e "${GREEN}Approach: PRODUCTION (full-stack, 10 quality gates)${NC}"
fi
echo -e "${GREEN}Type: $PROJECT_TYPE${NC}"
[ "$FRONTEND_FRAMEWORK" != "null" ] && echo -e "${GREEN}Frontend: $FRONTEND_FRAMEWORK${NC}"
[ "$BACKEND_FRAMEWORK" != "null" ] && echo -e "${GREEN}Backend: $BACKEND_FRAMEWORK${NC}"
echo ""

if [ "$APPROACH" = "prototype" ]; then
    echo -e "${YELLOW}PROTOTYPE MODE - Quality Gates:${NC}"
    echo "  ✓ Code Quality"
    echo "  ✓ Functionality"
    echo "  ✓ Mobile Responsive"
    echo "  ✓ UX Consistency"
    echo "  ✓ Documentation"
    echo ""
fi

echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Review config/workflow.config.yaml"
echo "  2. Customize CLAUDE.md with your commands"
echo "  3. Edit .github/workflows/quality-check.yml for your stack"
echo "  4. Start your first feature with a spec in docs/specs/"
echo ""
echo -e "${GREEN}Happy coding!${NC}"
