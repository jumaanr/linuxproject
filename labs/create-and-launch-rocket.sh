#!/bin/bash

function launch_rocket(){

    mission_name=$1

    mkdir $mission_name

    rocket-add $mission_name

    rocket-start-power $mission_name
    rocket-internal-power $mission_name
    rocket-start-sequence $mission_name
    rocket-start-engine $mission_name
    rocket-lift-off $mission_name

    rocket_status=$(rocket-status $mission_name)

    echo "The status of launch is $rocket_status"

    if [ $rocket_status = "launching" ]
    then
    sleep 2
    rocket_status=$(rocket-status $mission_name)
    fi

    if [ $rocket_status = "failed" ]
    then
    rocket-debug
    fi

}
launch_rocket $1