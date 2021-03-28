#!/usr/bin/env bash

export REPO_ROOT=$(git rev-parse --show-toplevel)

die() {
    echo "$*" 1>&2
    exit 1
}

need() {
    which "$1" &>/dev/null || die "Binary '$1' is missing but required"
}

need "sops"
need "kubectl"
need "sed"
need "envsubst"

# envsubst only picks up variables when this is set...
set -a

. "${REPO_ROOT}/secrets.env"

# Helper function to generate secrets
kseal() {
  echo "------------------------------------"
  # Get the path and basename of the txt file
  # e.g. "default/pihole/pihole-helm-values"
  secret="$(dirname "$@")/$(basename -s .txt "$@")"
  echo "Secret: ${secret}"
  # Get the filename without extension
  # e.g. "pihole-helm-values"
  secret_name=$(basename "${secret}")
  echo "Secret Name: ${secret_name}"
  # Extract the Kubernetes namespace from the secret path
  # e.g. default
  namespace="$(echo "${secret}" | awk -F $REPO_ROOT '{ print $2; }' | awk -F / '{ print $4; }')"
  echo "Namespace: ${namespace}"
  # Create secret and put it in the applications deployment folder
  # e.g. "default/pihole/pihole-helm-values.yaml"
  envsubst < "$@" | tee values.yaml \
    | \
  kubectl -n "${namespace}" create secret generic "${secret_name}" \
    --from-file=values.yaml --dry-run=client -o yaml \
    | \
  sops -e --input-type=yaml --output-type=yaml /dev/stdin \
    > "${secret}.enc.yaml"
  # Clean up temp file
  rm values.yaml
}

kseal "${REPO_ROOT}/cluster/infra/kube-system/oauth2-proxy/oauth2-proxy-helm-values.txt"
kseal "${REPO_ROOT}/cluster/infra/kube-system/dex/dex-helm-values.txt"
kseal "${REPO_ROOT}/cluster/infra/monitoring/grafana/grafana-helm-values.txt"
