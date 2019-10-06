#!/bin/bash
AWS_B64ENCODED_CREDENTIALS=$(clusterawsadm alpha bootstrap encode-aws-credentials)
sed "s/\${AWS_B64ENCODED_CREDENTIALS}/$AWS_B64ENCODED_CREDENTIALS/g" infrastructure-components.yaml \
  | kubectl apply -f -