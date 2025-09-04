# Observability Stack Helm Chart

This umbrella chart deploys a complete observability stack for Kubernetes, including:

- **Prometheus** - Metrics collection and storage
- **Grafana** - Visualization and dashboards
- **AlertManager** - Alert management
- **Node Exporter** - Host metrics
- **Kube State Metrics** - Kubernetes metrics

Future additions:
- **Loki** - Log aggregation
- **Tempo** - Distributed tracing
- **Alloy** - Log collection agent

## Prerequisites

- Kubernetes 1.26+
- Helm 3.8+
- StorageClass for persistent volumes (default: `k8s-csi`)

## Installation

### Add the repository

```bash
helm repo add homelab https://eli.github.io/homelab-helm
helm repo update
```

### Install the chart

```bash
helm install observability homelab/observability-stack \
  --namespace observability \
  --create-namespace
```

### Install with custom values

```bash
helm install observability homelab/observability-stack \
  --namespace observability \
  --create-namespace \
  -f my-values.yaml
```

## Configuration

### Basic Configuration

```yaml
# Change Grafana admin password
kubePrometheusStack:
  grafana:
    adminPassword: "my-secure-password"

# Adjust storage sizes
kubePrometheusStack:
  prometheus:
    prometheusSpec:
      storageSpec:
        volumeClaimTemplate:
          spec:
            resources:
              requests:
                storage: 200Gi  # Increase Prometheus storage

  alertmanager:
    alertmanagerSpec:
      storage:
        volumeClaimTemplate:
          spec:
            resources:
              requests:
                storage: 20Gi  # Increase AlertManager storage
```

### Disable Components

```yaml
# Disable AlertManager if not needed
kubePrometheusStack:
  alertmanager:
    enabled: false

# Disable Grafana if using external instance
kubePrometheusStack:
  grafana:
    enabled: false
```

## Accessing Services

### Using Port-Forward (Development)

```bash
# Grafana
kubectl port-forward -n observability svc/prometheus-grafana 3000:80
# Access at http://localhost:3000

# Prometheus
kubectl port-forward -n observability svc/prometheus-kube-prometheus-prometheus 9090:9090
# Access at http://localhost:9090

# AlertManager
kubectl port-forward -n observability svc/prometheus-kube-prometheus-alertmanager 9093:9093
# Access at http://localhost:9093
```

### Internal Cluster Access

Services are available at:
- Grafana: `http://prometheus-grafana.observability.svc.cluster.local`
- Prometheus: `http://prometheus-kube-prometheus-prometheus.observability.svc.cluster.local:9090`
- AlertManager: `http://prometheus-kube-prometheus-alertmanager.observability.svc.cluster.local:9093`

## Upgrade

```bash
helm upgrade observability homelab/observability-stack \
  --namespace observability \
  -f my-values.yaml
```

## Uninstall

```bash
helm uninstall observability --namespace observability
```

## Values

See [values.yaml](values.yaml) for full configuration options.

## Roadmap

- [ ] Add OAuth/OIDC authentication support
- [ ] Integrate Loki for logs
- [ ] Integrate Tempo for traces
- [ ] Add Alloy for collection
- [ ] Custom dashboards package
- [ ] Alert rules package