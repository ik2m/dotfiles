#!/bin/bash
# Claude Code status line (kawaii): model / ctx使用率 / 5h・7d 利用制限消費率
#
# jq はこの環境に無いので python3 で組み立てる。
# cat はコマンド置換の中で閉じるため、python3 の stdin には statusline の JSON が残る。
exec python3 -c "$(cat <<'PY'
import json, sys

try:
    d = json.load(sys.stdin)
except Exception:
    d = {}


def pct(*path):
    """値が無いことを 0% と混同しないよう、辿れなければ None を返す"""
    cur = d
    for k in path:
        if not isinstance(cur, dict):
            return None
        cur = cur.get(k)
    return cur if isinstance(cur, (int, float)) else None


def pick(p, low, mid, high):
    return low if p < 50 else mid if p < 80 else high


def part(label, p, faces, unknown):
    if p is None:
        return "%s %s --%%" % (label, unknown)
    return "%s %s %.0f%%" % (label, pick(p, *faces), p)


model = (d.get("model") or {}).get("display_name") or "?"
ctx = part("ctx", pct("context_window", "used_percentage"), ("(◕‿◕)", "(・_・;)", "(>_<)"), "(・-・)")
five = part("5h", pct("rate_limits", "five_hour", "used_percentage"), ("✨", "⏳", "🔥"), "💤")
week = part("7d", pct("rate_limits", "seven_day", "used_percentage"), ("💗", "💦", "😵"), "💤")

C = {"model": "\033[2;35m", "ctx": "\033[2;36m", "5h": "\033[2;33m", "7d": "\033[2;95m"}
R = "\033[0m"
sys.stdout.write(
    "%s🌸 %s%s ｜ %s%s%s ｜ %s%s%s ｜ %s%s%s"
    % (C["model"], model, R, C["ctx"], ctx, R, C["5h"], five, R, C["7d"], week, R)
)
PY
)"
