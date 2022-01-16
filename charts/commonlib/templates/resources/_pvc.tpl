{{- define "commonlib.resources.pvc" -}}
{{- $values := .Values.pvc -}}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.pvc -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}
{{- $pvcName := include "commonlib.fullname" . -}}
{{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
  {{- if not (eq $values.nameOverride "-") -}}
    {{- $pvcName = $values.nameOverride -}}
  {{ end -}}
{{ end }}
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ $pvcName }}
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
  accessModes:
    - {{ default "ReadWriteMany" $values.accessMode | quote }}
  resources:
    requests:
      storage: {{ default "1Gi" $values.size }}
  {{- if $values.storageClassName }}
  storageClassName: {{ $values.storageClassName }}
  {{- end }}  {{- if $values.volumeMode }}
  volumeMode: {{ $values.volumeMode }}
  {{- end }}
  volumeName: {{ default $pvcName $values.volumeName }}
{{- end -}}
