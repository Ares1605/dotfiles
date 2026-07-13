#!/bin/bash
set -euo pipefail

profile=$(aws configure list-profiles | fzf)

region=$(echo $'af-south-1
ap-east-1
ap-east-2
ap-northeast-1
ap-northeast-2
ap-northeast-3
ap-south-1
ap-south-2
ap-southeast-1
ap-southeast-2
ap-southeast-3
ap-southeast-4
ca-central-1
ca-west-1
eu-central-1
eu-central-2
eu-north-1
eu-south-1
eu-south-2
eu-west-1
eu-west-2
eu-west-3
il-central-1
me-central-1
me-south-1
mx-central-1
sa-east-1
us-gov-east-1
us-gov-west-1
cn-north-1
cn-northwest-1
us-west-1
us-west-2
us-east-2
us-east-1' | fzf)

echo "export AWS_PROFILE=\"$profile\""
echo "export AWS_REGION=\"$region\""
