{{/*
Expand the name of the chart.
*/}}
{{- define "observability-stack.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "observability-stack.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Generate Grafana admin password
Returns the provided password or generates a random one if empty
*/}}
{{- define "observability-stack.grafanaPassword" -}}
{{- if and .Values.kubePrometheusStack.grafana.adminPassword (ne .Values.kubePrometheusStack.grafana.adminPassword "") }}
{{- .Values.kubePrometheusStack.grafana.adminPassword }}
{{- else }}
{{- $secretObj := (lookup "v1" "Secret" .Release.Namespace (printf "%s-grafana-admin" .Release.Name)) | default dict }}
{{- $secretData := (get $secretObj "data") | default dict }}
{{- $currentPassword := (get $secretData "admin-password" | b64dec) | default "" }}
{{- if $currentPassword }}
{{- $currentPassword }}
{{- else }}
{{- randAlphaNum 16 }}
{{- end }}
{{- end }}
{{- end }}