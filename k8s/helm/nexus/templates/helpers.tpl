{{/*
Base name of the chart, overridable.
*/}}
{{- define "nexus.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Fully qualified app name.
*/}}
{{- define "nexus.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s" (include "nexus.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Common labels applied to every resource.
*/}}
{{- define "nexus.labels" -}}
app.kubernetes.io/name: {{ include "nexus.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app: {{ include "nexus.name" . }}
{{- end -}}

{{/*
Selector labels (stable subset used for matchLabels / Service selector).
*/}}
{{- define "nexus.selectorLabels" -}}
app: {{ include "nexus.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
