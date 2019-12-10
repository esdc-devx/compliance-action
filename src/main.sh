function parseInputs {
  # Required inputs
  if [ "${CLIENT_ID}" != "" ]; then
    export ARM_CLIENT_ID=${CLIENT_ID}
  else
    echo "CLIENT ID cannot be empty "
    exit 1
  fi

  if [ "${CLIENT_SECRET}" != "" ]; then
    export ARM_CLIENT_SECRET=${}
  else
    echo "CLIENT_SECRET cannot be empty"
    exit 1
  fi

  if [ "${TENANT_ID}" != "" ]; then
    export ARM_TENANT_ID=${TENANT_ID}
  else
    echo "TENANT_ID cannot be empty"
    exit 1
  fi

  if [ "${SUBSCRIPTION_ID}" != "" ]; then
    export ARM_SUBSCRIPTION_ID=${SUBSCRIPTION_ID}
  else
    echo "SUBSCRIPTION_ID cannot be empty"
    exit 1
  fi

}

function main { 
    terraform init
    terraform plan -out tf.plan
    terraform show -json tf.plan > tf.plan.json
    conftest test tf.plan.json
}