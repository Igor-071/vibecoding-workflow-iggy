#!/bin/bash

# =============================================================================
# Vibecoding Workflow - Add MOP Next.js Foundation
# =============================================================================
#
# Pulls the latest MOP Next.js foundation from
# https://github.com/ministryofprogramming/mop-foundation-nextjs
# and overlays it on the current project WITHOUT clobbering the vibecoding
# workflow files (CLAUDE.md, .claude/, config/, docs/, scripts/, etc.).
#
# Usage:
#   ./scripts/add-mop-foundation.sh              # pulls latest main
#   ./scripts/add-mop-foundation.sh v1.2.0       # pulls tag/branch/commit
#
# Safe to re-run. Existing foundation files are overwritten; workflow files
# are preserved.
#

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

REPO="ministryofprogramming/mop-foundation-nextjs"
REF="${1:-}"  # optional tag/branch/commit; empty = default branch
DEGIT_TARGET="$REPO"
[ -n "$REF" ] && DEGIT_TARGET="$REPO#$REF"

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Add MOP Next.js Foundation                            ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "Source: ${YELLOW}$DEGIT_TARGET${NC}"
echo ""

# -----------------------------------------------------------------------------
# Prerequisite checks
# -----------------------------------------------------------------------------
if ! command -v npx >/dev/null 2>&1; then
    echo -e "${RED}Error: npx not found. Install Node.js first.${NC}"
    exit 1
fi

if ! command -v rsync >/dev/null 2>&1; then
    echo -e "${RED}Error: rsync not found.${NC}"
    exit 1
fi

# Must be run from project root (sanity check)
if [ ! -f "CLAUDE.md" ]; then
    echo -e "${RED}Error: CLAUDE.md not found. Run this from the project root.${NC}"
    exit 1
fi

# -----------------------------------------------------------------------------
# Warn on existing Next.js files
# -----------------------------------------------------------------------------
CONFLICT=0
for f in package.json next.config.js next.config.mjs tsconfig.json; do
    if [ -f "$f" ]; then
        CONFLICT=1
        break
    fi
done

if [ "$CONFLICT" = "1" ]; then
    echo -e "${YELLOW}Warning: Next.js-related files already exist (package.json, next.config.*, tsconfig.json).${NC}"
    echo "They will be OVERWRITTEN by the MOP foundation."
    read -p "Continue? (y/n): " CONFIRM
    if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
        echo "Cancelled."
        exit 0
    fi
fi

# -----------------------------------------------------------------------------
# Fetch foundation to a temp directory
# -----------------------------------------------------------------------------
TMP_DIR=$(mktemp -d)
trap "rm -rf '$TMP_DIR'" EXIT

echo -e "${YELLOW}Fetching foundation into temporary directory...${NC}"
npx --yes degit "$DEGIT_TARGET" "$TMP_DIR" --force

if [ ! -d "$TMP_DIR" ] || [ -z "$(ls -A "$TMP_DIR")" ]; then
    echo -e "${RED}Error: degit produced an empty directory.${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Foundation fetched${NC}"
echo ""

# -----------------------------------------------------------------------------
# Copy foundation files into project, skipping vibecoding workflow files
# -----------------------------------------------------------------------------
echo -e "${YELLOW}Overlaying foundation onto project (preserving workflow files)...${NC}"

# Files/dirs the workflow owns — never overwrite these.
# .gitignore is handled specially (merged) below.
rsync -a \
    --exclude='CLAUDE.md' \
    --exclude='CLAUDE.local.md' \
    --exclude='CLAUDE.local.md.example' \
    --exclude='.claude/' \
    --exclude='.mcp.json' \
    --exclude='config/' \
    --exclude='docs/METHODOLOGY.md' \
    --exclude='docs/WORKFLOW_RULES.md' \
    --exclude='docs/QUICK_REFERENCE.md' \
    --exclude='docs/SPEC_TEMPLATE.md' \
    --exclude='docs/README.md' \
    --exclude='docs/specs/' \
    --exclude='docs/reviews/' \
    --exclude='docs/features/' \
    --exclude='docs/bugs/' \
    --exclude='scripts/' \
    --exclude='.gitignore' \
    --exclude='.git/' \
    "$TMP_DIR/" .

echo -e "${GREEN}✓ Foundation files copied${NC}"

# -----------------------------------------------------------------------------
# Merge .gitignore if the foundation has one
# -----------------------------------------------------------------------------
if [ -f "$TMP_DIR/.gitignore" ]; then
    echo -e "${YELLOW}Merging .gitignore entries from foundation...${NC}"
    MERGE_MARKER="# --- merged from MOP foundation ---"

    # Only add the block once
    if ! grep -qF "$MERGE_MARKER" .gitignore 2>/dev/null; then
        {
            echo ""
            echo "$MERGE_MARKER"
            cat "$TMP_DIR/.gitignore"
        } >> .gitignore
        echo -e "${GREEN}✓ .gitignore merged${NC}"
    else
        echo -e "${YELLOW}.gitignore already contains MOP foundation entries — skipped${NC}"
    fi
fi

# -----------------------------------------------------------------------------
# Summary
# -----------------------------------------------------------------------------
echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Foundation installed                                   ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. npm install          # install foundation dependencies"
echo "  2. Review any new files (git status) before committing"
echo "  3. npm run dev          # start the dev server"
echo ""
echo -e "${YELLOW}Re-run this script any time to pull the latest foundation:${NC}"
echo "  ./scripts/add-mop-foundation.sh"
echo ""
echo -e "${GREEN}Done.${NC}"
