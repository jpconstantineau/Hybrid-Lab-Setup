#!/bin/bash

#https://blog.alexellis.io/multi-master-ha-kubernetes-in-5-minutes/

set -e

export K8SVERSION=v1.23.3+k3s1

export NODE_1=172.16.0.1
export NODE_2=172.16.0.2
export NODE_3=172.16.0.3
export USER=ubuntu


# The first server starts the cluster
k3sup install \
  --cluster \
  --user $USER \
  --ip $NODE_1 \
  --k3s-version $K8SVERSION \
  --ssh-key $HOME/key


sleep 2

# The second node joins
k3sup join \
  --server \
  --ip $NODE_2 \
  --user $USER \
  --server-user $USER \
  --server-ip $NODE_1 \
  --k3s-version $K8SVERSION \
  --ssh-key $HOME/key


sleep 2

# The third node joins
k3sup join \
  --server \
  --ip $NODE_3 \
  --user $USER \
  --server-user $USER \
  --server-ip $NODE_1 \
  --k3s-version $K8SVERSION \
  --ssh-key $HOME/key

echo "Set your KUBECONFIG"
echo "export KUBECONFIG=`pwd`/kubeconfig"