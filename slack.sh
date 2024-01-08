#!/bin/bash

build_path="/teams/${BUILD_TEAM_NAME}/pipelines/${BUILD_PIPELINE_NAME}/jobs/${BUILD_JOB_NAME}/builds/${BUILD_NAME}"

if [ -n "${BUILD_PIPELINE_INSTANCE_VARS}" ]; then
    flattened_instance_vars=$(echo "${BUILD_PIPELINE_INSTANCE_VARS}" | jq -c -r 'to_entries | map("vars.\(.key)=\(.value|tostring|@uri)") | join("&")')
    query_string="?${flattened_instance_vars}"
else
    query_string=""
fi

URL="${ATC_EXTERNAL_URL}${build_path}${query_string}"