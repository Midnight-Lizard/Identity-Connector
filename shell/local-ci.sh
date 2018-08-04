#!/bin/sh
set -e
PROJ=identity-connector
IMAGE=debezium/connect:0.8.0.Final
kubectl config use-context minikube
helm upgrade --install --set image=$IMAGE $PROJ ../kube/postgres-connector
