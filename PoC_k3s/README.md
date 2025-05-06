# PoC_k3s

This repo contains:

- A Helm chart (`charts/dvwa`) that spins up `students` DVWA instances,
  each exposed via a LoadBalancer Service (MetalLB will assign external IPs).
- An Argo CD Application manifest (`apps/dvwa-application.yaml`) that deploys that chart.

---

## Deploying

1. **Add this repo** to Argo CD (via UI or CLI).
2. **Sync** the `dvwa` application.

---

## Changing the student count

You **do not** need to edit Git to change the number of pods. Use Argo CD’s Helm parameter override:

```bash
# Set the new student count (e.g. 10)
argocd app set dvwa --helm-set students=10

# Trigger a sync
argocd app sync dvwa
```

This patches the in-cluster Application to override `values.students` without touching Git, and then redeploys.

---

## Cleanup

```bash
kubectl delete namespace dvwa
argocd app delete dvwa
```