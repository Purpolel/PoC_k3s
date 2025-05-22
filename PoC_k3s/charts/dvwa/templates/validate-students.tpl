{{- /*
   1) Valideer aantal studenten
   2) Faal als er al Pods zijn in deze namespace (om dubbele deploys te voorkomen)
*/ -}}
{{- if or (lt .Values.students 1) (gt .Values.students 10) }}
{{- fail (printf "Invalid .Values.students: %d (moet tussen 1 en 10 liggen)" .Values.students) }}
{{- end }}

{{- /*
   Zorg dat er maximaal 1 ArgoCD Application per target-namespace bestaat.
*/ -}}
{{- $targetNS := .Release.Namespace -}}
{{- $ourApp := .Release.Name -}}
{{- /* lookup alle ArgoCD Applications uit de argocd namespace */ -}}
{{- $apps := lookup "argoproj.io/v1alpha1" "Application" "argocd" "" -}}
{{- if $apps -}}
  {{- range $app := $apps.items -}}
    {{- /* sla onze eigen Application over */ -}}
    {{- if and (ne $app.metadata.name $ourApp) (eq $app.spec.destination.namespace $targetNS) -}}
      {{- fail (printf
           "🚫 Namespace '%s' wordt al beheerd door ArgoCD Application '%s'.\n"
           "Je kunt maar één Application per namespace hebben."
           $targetNS $app.metadata.name
         )
      -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
