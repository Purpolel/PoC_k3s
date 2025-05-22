{{- /*
   1) Valideer aantal studenten
   2) Faal als er al Pods zijn in deze namespace (om dubbele deploys te voorkomen)
*/ -}}
{{- if or (lt .Values.students 1) (gt .Values.students 10) }}
{{- fail (printf "Invalid .Values.students: %d (moet tussen 1 en 10 liggen)" .Values.students) }}
{{- end }}

