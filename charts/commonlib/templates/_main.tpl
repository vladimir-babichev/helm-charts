{{/*
Main entrypoint for the common library chart. It will render all underlying templates based on the provided values.
*/}}
{{- define "commonlib.main" -}}
  {{- /* Merge the local chart values and the common chart defaults */ -}}
  {{- include "commonlib.values.setup" . }}

  {{- include "commonlib.volumes" . }}

  {{- if ((.Values.traefik).middleware) -}}
    {{- include "commonlib.traefik.middleware" . }}
  {{- end -}}
{{- end -}}
