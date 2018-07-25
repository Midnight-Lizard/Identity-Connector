kubectl create configmap identity-connector-config \
    --from-file=../config/ \
    -o yaml --dry-run \
    | kubectl replace -f -
