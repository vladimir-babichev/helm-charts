{{- define "common.volumes" -}}
  {{- /* Generate pvc as required */ -}}
  {{- range $name, $volume := .Values.volumes }}
    {{- if $volume.enabled }}
      {{- $volumeValues := $volume -}}
      {{- if not $volumeValues.nameOverride -}}
        {{- $volumeName := printf "%s-%s" (include "common.fullname" $) $name -}}
        {{- $_ := set $volumeValues "nameOverride" $volumeName -}}
      {{- end -}}
      {{- $_ := set $ "ObjectValues" (dict "pv" $volumeValues) -}}
      {{- include "common.resources.pv" $ | nindent 0 -}}
      {{- $_ := set $ "ObjectValues" (dict "pvc" $volumeValues) -}}
      {{- include "common.resources.pvc" $ | nindent 0 -}}
    {{- end }}
  {{- end }}
{{- end }}
