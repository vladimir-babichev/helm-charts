{{- define "commonlib.resources.traefik.middleware" -}}
{{- $values := .Values.traefik.middleware -}}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.traefik.middleware -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}
{{- $mwName := include "commonlib.fullname" . -}}
{{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
  {{- if not (eq $values.nameOverride "-") -}}
    {{- $mwName = $values.nameOverride -}}
  {{ end -}}
{{ end }}
---
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: {{ $mwName | quote }}
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
  {{- toYaml $values.spec | nindent 2 }}
{{- end -}}
