{{- define "commonlib.resources.ingress" -}}
  {{- $values := .Values.ingress -}}
  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.ingress -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}
  {{- $ingressName := include "commonlib.fullname" . -}}
  {{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
    {{- if not (eq $values.nameOverride "-") -}}
      {{- $ingressName = $values.nameOverride -}}
    {{ end -}}
  {{ end }}
  {{- $fullName := include "commonlib.fullname" . -}}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ $ingressName }}
  labels:
    {{- include "commonlib.labels" . | nindent 4 }}
    {{- with $values.labels }}
      {{- toYaml $values.labels | nindent 4 }}
    {{- end }}
  annotations:
    {{- with $values.annotations }}
      {{- toYaml $values.annotations | nindent 4 }}
    {{- end }}
spec:
  {{- if $values.ingressClassName }}
  ingressClassName: {{ $values.ingressClassName }}
  {{- end }}
  rules:
  {{- range $values.hosts }}
    - host: {{ .host }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            pathType: {{ default "Prefix" .pathType }}
            backend:
              service:
                name: {{ default $fullName (.service).name }}
                port:
                  number: {{ default "8080" (.service).port }}
          {{- end }}
  {{- end }}
  {{- if $values.tls }}
  tls:
    {{- range $values.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ . }}
        {{- end }}
      {{- if .secretName }}
      secretName: {{ .secretName }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end -}}
