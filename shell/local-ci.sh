#!/bin/sh
set -e
kubectl config use-context minikube
helm upgrade --install identity-connector ../kube/postgres-connector
helm upgrade --install identity-compactor ../kube/compactor
