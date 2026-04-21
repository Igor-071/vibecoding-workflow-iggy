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
        echo -e "${RED}Invalid choice. Please enter 1 or 2.${NC}"
        exit 1
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
    echo "  1) nextjs    - Next.js (recommended — MOP foundation available)"
    echo "  2) react     - React"
    echo "  3) vue       - Vue.js"
    echo "  4) svelte    - Svelte"
    echo "  5) angular   - Angular"
    echo "  6) vanilla   - Vanilla JS"
    echo "  7) none      - No frontend"
    read -p "Select frontend framework (1-7): " FE_CHOICE

    case $FE_CHOICE in
        1) FRONTEND_FRAMEWORK="nextjs" ;;
        2) FRONTEND_FRAMEWORK="react" ;;
        3) FRONTEND_FRAMEWORK="vue" ;;
        4) FRONTEND_FRAMEWORK="svelte" ;;
        5) FRONTEND_FRAMEWORK="angular" ;;
        6) FRONTEND_FRAMEWORK="vanilla" ;;
        7) FRONTEND_FRAMEWORK="null" ;;
        *) FRONTEND_FRAMEWORK="nextjs" ;;
    esac

    echo -e "${GREEN}✓ Frontend: $FRONTEND_FRAMEWORK${NC}"
    echo ""

    # Offer MOP Next.js foundation scaffold
    SCAFFOLD_MOP="n"
    if [ "$FRONTEND_FRAMEWORK" = "nextjs" ]; then
        echo -e "${YELLOW}Scaffold from MOP Next.js foundation?${NC}"
        echo "  Pulls latest from github.com/ministryofprogramming/mop-foundation-nextjs"
        echo "  Workflow files (CLAUDE.md, .claude/, config/, docs/, scripts/) are preserved."
        read -p "Scaffold now? (y/n): " SCAFFOLD_MOP
        echo ""
    fi
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
        sed -i.bak "s/  responsive:/  responsive:\n    enabled: false/g" config/workflow.config.yaml
        sed -i.bak "s/  accessibility:/  accessibility:\n    enabled: false/g" config/workflow.config.yaml
        sed -i.bak "s/  cross_browser:/  cross_browser:\n    enabled: false/g" config/workflow.config.yaml
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
    sed -i.bak "s/\[APPROACH\]/$APPROACH/g" CLAUDE.md

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
# MOP Next.js Foundation Scaffold (optional)
# -----------------------------------------------------------------------------
if [ "${SCAFFOLD_MOP:-n}" = "y" ] || [ "${SCAFFOLD_MOP:-n}" = "Y" ]; then
    echo ""
    echo -e "${YELLOW}Scaffolding MOP Next.js foundation...${NC}"
    if [ -x "./scripts/add-mop-foundation.sh" ]; then
        ./scripts/add-mop-foundation.sh || echo -e "${YELLOW}Foundation scaffold failed — re-run ./scripts/add-mop-foundation.sh manually.${NC}"
    else
        echo -e "${YELLOW}scripts/add-mop-foundation.sh not executable — skipping. Run: chmod +x scripts/add-mop-foundation.sh && ./scripts/add-mop-foundation.sh${NC}"
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
    echo "  ✓ Tests pass"
    echo "  ✓ Lint clean"
    echo "  ✓ All ACs met"
    echo "  ✓ Responsive"
    echo "  ✓ Code review"
    echo ""
fi

echo -e "${YELLOW}Tooling setup:${NC}"
echo "  Hooks     → .claude/settings.json (auto-lint + pre-commit already configured)"
echo "  MCP       → .mcp.json (context7, playwright, sequential-thinking, memory work now)"
echo "  GitHub MCP → requires: export GITHUB_TOKEN=ghp_your_token"
echo ""
echo -e "${YELLOW}Personal preferences:${NC}"
echo "  cp CLAUDE.local.md.example CLAUDE.local.md"
echo "  # Edit CLAUDE.local.md — it is gitignored"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
if [ "$FRONTEND_FRAMEWORK" = "nextjs" ] && [ "${SCAFFOLD_MOP:-n}" != "y" ] && [ "${SCAFFOLD_MOP:-n}" != "Y" ]; then
    echo "  1. Scaffold foundation: ./scripts/add-mop-foundation.sh"
    echo "  2. npm install && npm run dev"
    echo "  3. Customize CLAUDE.md with your project's actual commands"
    echo "  4. Start your first feature: type /spec in Claude Code"
elif [ "${SCAFFOLD_MOP:-n}" = "y" ] || [ "${SCAFFOLD_MOP:-n}" = "Y" ]; then
    echo "  1. npm install          # install foundation dependencies"
    echo "  2. npm run dev          # start dev server"
    echo "  3. Start your first feature: type /spec in Claude Code"
    echo "  4. Re-pull latest foundation any time: ./scripts/add-mop-foundation.sh"
else
    echo "  1. Customize CLAUDE.md with your project's actual commands"
    echo "  2. Set GITHUB_TOKEN if you want GitHub MCP (issues, PRs, code search)"
    echo "  3. Start your first feature: create a spec in docs/specs/"
    echo "     (or type /spec in Claude Code)"
fi
echo ""
echo -e "${GREEN}Happy coding!${NC}"
