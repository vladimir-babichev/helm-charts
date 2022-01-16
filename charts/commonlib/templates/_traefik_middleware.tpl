{{- define "commonlib.traefik.middleware" -}}
  {{- /* Generate traefik middleware as required */ -}}
  {{- range $name, $mw := .Values.traefik.middleware }}
    {{- if $mw.enabled }}
      {{- $mwValues := $mw -}}
      {{- if not $mwValues.nameOverride -}}
        {{- $mwName := printf "%s-%s" (include "commonlib.fullname" $) $name -}}
        {{- $_ := set $mwValues "nameOverride" $mwName -}}
      {{- end -}}
      {{- $_ := set $ "ObjectValues" (dict "traefik" (dict "middleware" $mwValues)) -}}
      {{- include "commonlib.resources.traefik.middleware" $ | nindent 0 -}}
    {{- end }}
  {{- end }}
{{- end }}
