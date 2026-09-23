#!/usr/bin/env bash
# Claude Code status line — model, dir, git, context %, cost, output style.
# Receives session JSON on stdin.

input=$(cat)

# --- Extract fields from stdin JSON (one per line; values may contain spaces) ---
{
  IFS= read -r model
  IFS= read -r cur_dir
  IFS= read -r project_dir
  IFS= read -r output_style
  IFS= read -r cost
  IFS= read -r lines_added
  IFS= read -r lines_removed
  IFS= read -r transcript
  IFS= read -r exceeds
} < <(
  printf '%s' "$input" | jq -r '
    (.model.display_name // "Claude"),
    (.workspace.current_dir // .cwd // ""),
    (.workspace.project_dir // ""),
    (.output_style.name // "default"),
    (.cost.total_cost_usd // 0 | tostring),
    (.cost.total_lines_added // 0 | tostring),
    (.cost.total_lines_removed // 0 | tostring),
    (.transcript_path // ""),
    (.exceeds_200k_tokens // false | tostring)'
)

# --- ANSI (dimmed accents) ---
RESET=$'\033[0m'; DIM=$'\033[2m'
CYAN=$'\033[36m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'
MAGENTA=$'\033[35m'; BLUE=$'\033[34m'; RED=$'\033[31m'

# --- Directory (~ for $HOME) ---
disp_dir="${cur_dir/#$HOME/~}"
[ -z "$disp_dir" ] && disp_dir="~"

# --- Git branch / short SHA ---
git_seg=""
if [ -n "$cur_dir" ] && git -C "$cur_dir" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cur_dir" --no-optional-locks branch --show-current 2>/dev/null)
  [ -z "$branch" ] && branch=$(git -C "$cur_dir" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    dirty=""
    git -C "$cur_dir" --no-optional-locks diff --quiet --ignore-submodules HEAD >/dev/null 2>&1 || dirty="*"
    git_seg=" ${DIM}·${RESET} ${MAGENTA}⎇ ${branch}${dirty}${RESET}"
  fi
fi

# --- Context window usage % (from latest transcript usage) ---
ctx_seg=""
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  tokens=$(tail -n 100 "$transcript" 2>/dev/null | jq -s -r '
    [ .[] | select(.message.usage != null) | .message.usage ] as $u
    | if ($u | length) > 0 then
        ($u[-1] | (.input_tokens // 0) + (.cache_read_input_tokens // 0) + (.cache_creation_input_tokens // 0))
      else 0 end' 2>/dev/null)
  if [ -n "$tokens" ] && [ "$tokens" -gt 0 ] 2>/dev/null; then
    limit=200000
    [ "$exceeds" = "true" ] && limit=1000000
    pct=$(( tokens * 100 / limit ))
    ccol=$GREEN
    [ "$pct" -ge 60 ] && ccol=$YELLOW
    [ "$pct" -ge 85 ] && ccol=$RED
    ctx_seg=" ${DIM}·${RESET} ${ccol}${pct}% ctx${RESET}"
  fi
fi

# --- Cost + lines changed ---
cost_fmt=$(printf '%.2f' "$cost" 2>/dev/null || echo "0.00")
cost_seg=" ${DIM}·${RESET} ${GREEN}\$${cost_fmt}${RESET}"
if [ "${lines_added:-0}" != "0" ] || [ "${lines_removed:-0}" != "0" ]; then
  cost_seg="${cost_seg} ${DIM}(${GREEN}+${lines_added}${DIM}/${RED}-${lines_removed}${DIM})${RESET}"
fi

# --- Output style (only if non-default) ---
style_seg=""
if [ -n "$output_style" ] && [ "$output_style" != "default" ] && [ "$output_style" != "null" ]; then
  style_seg=" ${DIM}·${RESET} ${BLUE}${output_style}${RESET}"
fi

# --- Assemble ---
printf '%b' "${CYAN}${model}${RESET} ${DIM}·${RESET} ${DIM}${disp_dir}${RESET}${git_seg}${ctx_seg}${cost_seg}${style_seg}"
