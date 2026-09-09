#!/bin/bash
set -euo pipefail

if test -z "$KUBECONFIG"; then
  echo "❌ The CAPI install script requires that environment variable KUBECONFIG is set."
  exit 1
fi

if test -z "$VAULT_ADDR"; then
  echo "❌ The CAPI install script requires that environment variable VAULT_ADDR is set."
  exit 1
fi

if ! kubectl get ns syn-cert-manager &>/dev/null; then
  echo "Installing Project Syn cert-manager instance..."
  kubectl apply --server-side -f catalog/manifests/cert-manager/00_namespace.yaml
  kapitan refs --reveal --refs-path catalog/refs \
    -f catalog/manifests/cert-manager/10_cert_manager | \
    yq 'select(.apiVersion != "monitoring.coreos.com/v1")' | \
    kubectl apply --server-side -f -
else
  echo "✅ Namespace syn-cert-manager already exists on the target cluster, assuming that cert-manager is already installed..."
fi

echo "Waiting for cert-manager deployments to become ready..."
kubectl wait -n syn-cert-manager --for=condition=available --timeout=60s \
  deploy/cert-manager deploy/cert-manager-webhook
echo "✅ Project Syn cert-manager is ready."

if ! kubectl get ns syn-cluster-api &>/dev/null; then
  echo -e "\n\nInstalling Project Syn cluster API providers..."
  kubectl apply --server-side -f catalog/manifests/capi-core/00_namespace.yaml
  echo "Installing CAPI provider..."
  kapitan refs --reveal --refs-path catalog/refs \
    -f catalog/manifests/capi-core/cluster-api/10_kustomize | \
    yq 'select(.apiVersion != "monitoring.coreos.com/v1")' | \
    kubectl apply --server-side -f -

  echo "Installing Talos CAPI providers..."
  kapitan refs --reveal --refs-path catalog/refs \
    -f catalog/manifests/capi-provider-talos/bootstrap/10_kustomize | \
    yq 'select(.apiVersion != "monitoring.coreos.com/v1")' | \
    kubectl apply --server-side -f -
  kapitan refs --reveal --refs-path catalog/refs \
    -f catalog/manifests/capi-provider-talos/controlplane/10_kustomize | \
    yq 'select(.apiVersion != "monitoring.coreos.com/v1")' | \
    kubectl apply --server-side -f -

  echo "Installing cloudscale CAPI provider..."
  kapitan refs --reveal --refs-path catalog/refs \
    -f catalog/manifests/capi-provider-cloudscale/10_kustomize | \
    yq 'select(.apiVersion != "monitoring.coreos.com/v1")' | \
    kubectl apply --server-side -f -

  echo "✅ Cluster API initialized successfully."
else
  echo -e "\n\n✅ Namespace syn-cluster-api already exists on target cluster, assuming that CAPI is already installed..."
fi

echo "Waiting for CAPI provider controller-managers to become available..."
kubectl wait -n syn-cluster-api --for=condition=available --timeout=60s \
  deploy/capi-controller-manager \
  deploy/cabpt-controller-manager \
  deploy/cacppt-controller-manager \
  deploy/capcs-controller-manager
echo "✅ Cluster API providers ready."
