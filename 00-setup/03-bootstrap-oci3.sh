export GITHUB_TOKEN=<your-github-token>
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

flux bootstrap github \
  --network-policy=false \
  --owner=jpconstantineau \
  --repository=Hybrid-Lab-Setup \
  --path=clusters/oci3 \
  --personal