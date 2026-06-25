#!/usr/bin/env bash
# Daily GitHub activity: appends a research log entry and pushes.
# Usage: ./github_daily_commit.sh [repo_dir]
# Cron: 0 20 * * * /home/user213/github_daily_commit.sh /home/user213/model_train

set -e

REPO_DIR="${1:-/home/user213/model_train}"
LOG_FILE="$REPO_DIR/RESEARCH_LOG.md"
DATE=$(date '+%Y-%m-%d')
WEEKDAY=$(date '+%A')

# Init log file if missing
if [ ! -f "$LOG_FILE" ]; then
    echo "# Research Log" > "$LOG_FILE"
    echo "" >> "$LOG_FILE"
fi

# Skip if today's entry already exists
if grep -q "^## $DATE" "$LOG_FILE"; then
    echo "[$DATE] Entry already exists, skipping."
    exit 0
fi

# Append today's stub (edit manually to add real notes)
cat >> "$LOG_FILE" << EOF

## $DATE ($WEEKDAY)

- [ ] Experiment:
- [ ] Result:
- [ ] Next:

EOF

cd "$REPO_DIR"
git add RESEARCH_LOG.md
git commit -m "chore: research log $DATE"
git push
echo "[$DATE] Committed and pushed research log."
