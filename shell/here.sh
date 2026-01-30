#!/usr/bin/env bash
set -e

APIDIR="api/proto"

# 打开gitlab
gitlab_here() {
  push_remote=$(git remote -v | grep 'push' | awk '{print $2}')
  push_repo=${push_remote#*:}
  push_repo=${push_repo%.*}
  open "https://git.wsn/$push_repo/-/tree/$(git branch --show-current)"
}

# 打开swagger
swagger_here() {
  push_remote=$(git remote -v | grep 'push' | awk '{print $2}')
  push_repo=${push_remote#*:}
  push_repo=${push_repo%.*}
  open "https://swagger.wsn.net/$push_repo/$(git branch --show-current)"
}

# 打开drone ci
drone_here() {
  push_remote=$(git remote -v | grep 'push' | awk '{print $2}')
  push_repo=${push_remote#*:}
  push_repo=${push_repo%.*}
  open "https://drone.wsn.net/$push_repo"
}

# 打开swagger
swagger_markdown_here() {
  push_remote=$(git remote -v | grep 'push' | awk '{print $2}')
  push_repo=${push_remote#*:}
  push_repo=${push_repo%.*}
  local list=$(find "$APIDIR" -name "*openapi*yaml*" | grep -E "$1")
  util::select "请选择打开的yaml" "${list[*]}"
  echo ${selected}
  local branch=$(git branch --show-current)
  open "https://swagger.wsn.net/content/$push_repo/${selected}?ref=${branch}&format=markdown" #$(git branch --show-current)"
}

pipeline_here() {
  push_remote=$(git remote -v | grep 'push' | awk '{print $2}')
  push_repo=${push_remote#*:}
  push_repo=${push_repo%.*}
  open "https://devops.wsn.net/pub/pipeline/list?keyword=$push_repo"
}

main() {
  local list=("gitlab" "swagger" "drone" "swagger_markdown" "pipeline")

  if [ -z $1 ]; then
    util::select "要访问的选项？" "${list[*]}"
    $selected"_here"
    exit 0
  fi

  case $1 in
  gitlab)
    gitlab_here
    ;;
  g)
    gitlab_here
    ;;
  swagger)
    swagger_here
    ;;
  s)
    swagger_here
    ;;
  drone)
    drone_here
    ;;
  d)
    drone_here
    ;;
  md)
    shift
    swagger_markdown_here $@
    ;;
  pipeline)
    shift
    pipeline_here $@
    ;;
  esac
}

main $@
