{{- define "commonlib.volumes" -}}
  {{- /* Generate pvc as required */ -}}
  {{- range $name, $volume := .Values.volumes }}
    {{- if $volume.enabled }}
      {{- $volumeValues := $volume -}}
      {{- if not $volumeValues.nameOverride -}}
        {{- $volumeName := printf "%s-%s" (include "commonlib.fullname" $) $name -}}
        {{- $_ := set $volumeValues "nameOverride" $volumeName -}}
      {{- end -}}
      {{- $_ := set $ "ObjectValues" (dict "pv" $volumeValues) -}}
      {{- include "commonlib.resources.pv" $ | nindent 0 -}}
      {{- $_ := set $ "ObjectValues" (dict "pvc" $volumeValues) -}}
      {{- include "commonlib.resources.pvc" $ | nindent 0 -}}
    {{- end }}
  {{- end }}
{{- end }}
