#!/usr/bin/env bash
set -e

build() {
  local list=$(util::get_project_list $1)
  if [ -z "${list[0]}" ]; then # Check if the first element of the list is an empty string
    echo "没有匹配的项目"
    return
  fi

  local items=()
  # 正确处理项目名称，特别是包含空格的情况
  for p_name in $list; do
    items+=("$p_name")
  done

  if [ "${#items[@]}" -eq 1 ]; then
    selected=${items[0]}
    _runbuild ${selected}
    exit
  fi

  util::select "请选择编译项目" "${items[*]}"
  _runbuild ${selected}
}

buildall() {
  local list=$(util::get_project_list $1)
  for p_name in ${list[*]}; do
    _runbuild ${p_name}
  done
}

_runbuild() {
  if [ ! -d "./internal/$1/" ]; then
    log::fatal "编译项目不存在: ./internal/$1/"
  fi

  log::info "$(date "+%Y-%m-%d %H:%M:%S") 开始编译: $1"
  mkdir -p "./bin/$1"
  [ "$DRONE" != "true" ] && go generate -skip=wire "./internal/$1/..." && wire "./internal/$1/..."
  go build -o "./bin/$1/app" "./internal/$1/"
  if [ $? -eq 0 ]; then
    log::info "********** $1 编译成功 ***********"
  else
    log::fatal "********** $1 编译失败 ***********"
  fi
}

main() {
  case ${1} in
  all)
    buildall $2
    ;;
  *)
    build $1
    ;;
  esac
}

main $@
