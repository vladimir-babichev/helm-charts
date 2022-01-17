{{- define "commonlib.ingress" -}}
  {{- /* Generate pvc as required */ -}}
  {{- range $name, $ingress := .Values.ingress }}
    {{- if $ingress.enabled }}
      {{- $ingressValues := $ingress -}}
      {{- if not $ingressValues.nameOverride -}}
        {{- $ingressName := printf "%s-%s" (include "commonlib.fullname" $) $name -}}
        {{- $_ := set $ingressValues "nameOverride" $ingressName -}}
      {{- end -}}
      {{- $_ := set $ "ObjectValues" (dict "ingress" $ingressValues) -}}
      {{- include "commonlib.resources.ingress" $ | nindent 0 -}}
    {{- end }}
  {{- end }}
{{- end }}
