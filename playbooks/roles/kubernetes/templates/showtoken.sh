#!/bin/bash
kubectl describe secret $(kubectl get serviceaccounts default -n kube-system -o=jsonpath='{.secrets[0].name}') -n kube-system | grep ^token