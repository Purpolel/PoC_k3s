# PoC_k3s

Deze repo bevat:

- Een Helm-chart (`charts/dvwa`) die `students`-DVWA-instances opstart,
  elk toegankelijk via een eigen Cloudflare-DNS.
- Een Argo CD-Application-manifest (`apps/dvwa-application.yaml`) dat deze chart uitrolt.

---

## Deployen

1. **Voeg deze repo** toe aan Argo CD (via de UI of CLI).
2. **Sync** de `dvwa`-applicatie.

---

## Het aantal studenten aanpassen

Je **hoeft Git niet te bewerken** om het aantal pods te wijzigen. Gebruik de Helm-parameter-override van Argo CD:
GUI:
- Selecteer values.yaml file
- Voer aantal studenten in

Console:

```bash
# Stel het nieuwe aantal studenten in (bijv. 10)
argocd app set dvwa --helm-set students=10

# Start een sync
argocd app sync dvwa
