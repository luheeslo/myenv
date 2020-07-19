#!/usr/bin/env bash
set -e

if [[ -z "${MYENV}" ]]; then
  MY_ENV="my_env"
else
  MY_ENV="${MYENV}"
fi

function usage {
    echo "Usage :  $0 [commands] [--]

Commands:
    run_env 	  Create and start the evnvironment container
    create_env    Create the environment container
    start_env     Start the environment container
    stop_env      Stop the the environment container already started
    remove_env    Remove the environment container"
}

function create_env {
    docker create -it --name my_env --mount type=bind,source="$(pwd)",target=/root/env lhel/myenv
}

function start_env {
    docker start -i $MY_ENV
}

function stop_env {
    docker stop $MY_ENV
}

function remove_env {
    docker rm -f $MY_ENV
}

function run_env {
    docker run -it --rm --name $MY_ENV --mount type=bind,source="$(pwd)",target=/root/env lhel/myenv
}

if [[ $# -lt 1 ]]; then
    usage
    exit 1
fi

TARGET=$1
case $TARGET in
  "help" )
    usage
  ;;
  "create_env" )
    create_env
  ;;
  "start_env" )
    start_env
  ;;
  "stop_env" )
    stop_env
  ;;
  "remove_env" )
    remove_env
  ;;
  "run_env" )
    run_env
  ;;
  *)
    echo "Unknown command '${TARGET}'"
    usage
    exit 1
  ;;
esac
