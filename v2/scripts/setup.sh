#!/usr/bin/env bash
set -euo pipefail

# Vibecoding v2 — One-command setup
# Usage: ./scripts/setup.sh

BOLD='\033[1m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BOLD}${BLUE}Vibecoding v2 Setup${NC}\n"

# 1. Project name
read -p "Project name: " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
  echo "Project name is required." && exit 1
fi

# 2. Mode
echo -e "\nMode:"
echo "  1) prototype  — Fast iteration, 5 quality gates"
echo "  2) production — Full rigor, 10 quality gates"
read -p "Choose [1/2]: " MODE_CHOICE
case $MODE_CHOICE in
  1) MODE="prototype" ;;
  2) MODE="production" ;;
  *) echo "Invalid choice." && exit 1 ;;
esac

# 3. Stack
echo -e "\nFrontend framework:"
echo "  1) React/Next.js   2) Vue/Nuxt   3) Svelte/SvelteKit"
echo "  4) Angular          5) Vanilla JS  6) Other"
read -p "Choose [1-6]: " FE_CHOICE
case $FE_CHOICE in
  1) STACK="React/Next.js" ;;
  2) STACK="Vue/Nuxt" ;;
  3) STACK="Svelte/SvelteKit" ;;
  4) STACK="Angular" ;;
  5) STACK="Vanilla JS" ;;
  6) read -p "Enter stack: " STACK ;;
  *) STACK="Not specified" ;;
esac

# 4. Update CLAUDE.md
sed -i "s/PROJECT_NAME/$PROJECT_NAME/" CLAUDE.md
sed -i "s/TECH_STACK/$STACK/" CLAUDE.md
sed -i "s/mode:.*/mode: $MODE/" CLAUDE.md

echo -e "\n${GREEN}Done.${NC} Updated CLAUDE.md with:"
echo -e "  Project: ${BOLD}$PROJECT_NAME${NC}"
echo -e "  Mode:    ${BOLD}$MODE${NC}"
echo -e "  Stack:   ${BOLD}$STACK${NC}"

# 5. Check MCP dependencies
echo -e "\n${BLUE}MCP Servers configured in .mcp.json:${NC}"
echo "  - context7    (real-time docs)"
echo "  - github      (issues, PRs, code search)"
echo "  - playwright  (browser testing)"
echo "  - sequential-thinking (structured reasoning)"
echo "  - memory      (persistent knowledge)"

if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo -e "\n${YELLOW}Note:${NC} Set GITHUB_TOKEN env var for GitHub MCP server."
  echo "  export GITHUB_TOKEN=ghp_your_token_here"
fi

# 6. Hooks info
echo -e "\n${BLUE}Hooks configured in .claude/settings.json:${NC}"
echo "  - PostToolUse: Auto-lint JS/TS files on every write"
echo "  - PreCommit:   Run lint + tests before every commit"

echo -e "\n${GREEN}${BOLD}Setup complete.${NC} Start building:"
echo -e "  ${BOLD}claude${NC}  — Start Claude Code"
echo -e "  Tell Claude what to build. It will create a spec first."
echo -e "\nFor parallel sessions, use git worktrees:"
echo -e "  git worktree add ../feature-a -b feature-a"
echo -e "  cd ../feature-a && claude"
