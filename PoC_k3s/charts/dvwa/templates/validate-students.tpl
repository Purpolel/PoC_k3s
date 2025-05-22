{{- /*
   1) Valideer aantal studenten
   2) Faal als er al Pods zijn in deze namespace (om dubbele deploys te voorkomen)
*/ -}}
{{- if or (lt .Values.students 1) (gt .Values.students 10) }}
{{- fail (printf "Invalid .Values.students: %d (moet tussen 1 en 10 liggen)" .Values.students) }}
{{- end }}

{{- /* lookup alle pods in deze namespace */ -}}
{{- $all := lookup "v1" "Pod" .Release.Namespace "" }}
{{- if and $all $all.items }}
{{- fail (printf 
     "Namespace '%s' bevat al %d Pod(s). Verwijder eerst bestaande pods of gebruik een schone namespace." 
     .Release.Namespace (len $all.items)
   )
}}
{{- end }}
