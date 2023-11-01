#!/usr/bin/env bash

# ++-----------
# ||   08 - Apply Consul service intentions
# ++------
header1 "Apply Consul service intentions"

# ++-----------------+
# || Variables       |
# ++-----------------+

export STEP_ASSETS="${SCENARIO_OUTPUT_FOLDER}conf/"


## [cmd] [script] generate_consul_service_intentions.sh
log -l WARN -t '[SCRIPT]' "Generate L4 Intentions for services."  
execute_supporting_script "generate_consul_service_intentions.sh"


log "Apply service intentions"

consul config write ${STEP_ASSETS}global/intention-db.hcl
consul config write ${STEP_ASSETS}global/intention-api.hcl
consul config write ${STEP_ASSETS}global/intention-frontend.hcl
consul config write ${STEP_ASSETS}global/intention-nginx.hcl
consul config delete -kind service-intentions -name "*"


## Generate list of created files during scenario step
## The list is appended to the $LOG_FILES_CREATED file
get_created_files