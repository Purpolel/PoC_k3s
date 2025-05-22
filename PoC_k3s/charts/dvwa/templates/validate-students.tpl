{{- /* converteer de string naar int */ -}}
{{- $students := int .Values.students -}}

{{- /* 1) Valideer aantal studenten */ -}}
{{- if or (lt $students 1) (gt $students 10) }}
  {{- fail (printf "Invalid .Values.students: %d (moet tussen 1 en 10 liggen)" $students) }}
{{- end }}
