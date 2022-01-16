
{{/* Merge the local chart values and the common chart defaults */}}
{{- define "commonlib.values.setup" -}}
    {{- if .Values.common -}}
        {{- $defaultValues := deepCopy .Values.common -}}
        {{- $userValues := deepCopy (omit .Values "commonlib") -}}
        {{- $mergedValues := mustMergeOverwrite $defaultValues $userValues -}}
        {{- $_ := set . "Values" (deepCopy $mergedValues) -}}
    {{- end -}}
{{- end -}}
