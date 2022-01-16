{{- define "common.resources.pv" -}}
{{- $values := .Values.pv -}}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.pv -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}
{{- $pvName := include "common.fullname" . -}}
{{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
  {{- if not (eq $values.nameOverride "-") -}}
    {{- $pvName = $values.nameOverride -}}
  {{ end -}}
{{ end }}
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: {{ $pvName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
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
  capacity:
    storage: {{ default "1Gi" $values.size }}
  {{- if $values.nfs }}
  nfs:
    path: {{ $values.nfs.path }}/{{ $pvName }}
    server: {{ $values.nfs.server }}
  {{- end }}
  persistentVolumeReclaimPolicy: {{ default "Retain" $values.persistentVolumeReclaimPolicy }}
  {{- if $values.storageClassName }}
  storageClassName: {{ $values.storageClassName }}
  {{- end }}
  {{- if $values.volumeMode }}
  volumeMode: {{ $values.volumeMode }}
  {{- end }}
{{- end -}}
