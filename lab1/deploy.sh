#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/Artem362a/catty-reminders-app.git"
APP_DIR="/opt/devops-lab/app"
BRANCH="${1:-main}"   # ветка из webhook, по умолчанию main

if [ ! -d "$APP_DIR/.git" ]; then
  mkdir -p "$APP_DIR"
  git clone "$REPO_URL" "$APP_DIR"
fi

cd "$APP_DIR"
git fetch origin
git checkout "$BRANCH"
git pull origin "$BRANCH"

python3 -m venv venv
source venv/bin/activate
pip install -U pip
[ -f requirements.txt ] && pip install -r requirements.txt


sudo systemctl restart app-devops-lab.service || true
