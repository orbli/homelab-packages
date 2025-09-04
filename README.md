# Homelab Packages Monorepo

A centralized repository for all publishable packages including Helm charts, Go modules, Rust crates, Node.js packages, and Python packages.

## Repository Structure

```
.
├── charts/          # Helm charts
└── .github/        # GitHub Actions workflows
```

Future structure will support:
- `go/` - Go modules/libraries
- `rust/` - Rust crates  
- `nodejs/` - Node.js/npm packages
- `python/` - Python packages

## Package Types

### Helm Charts (`charts/`)
Kubernetes applications packaged as Helm charts. Published to GitHub Pages as a Helm repository.

### Go Modules (`go/`)
Go libraries and modules. Tagged with `go/module-name/vX.Y.Z` for release.

### Rust Crates (`rust/`)
Rust libraries published to crates.io. Tagged with `rust-crate-name-vX.Y.Z`.

### Node.js Packages (`nodejs/`)
NPM packages. Tagged with `nodejs-package-name-vX.Y.Z`.

### Python Packages (`python/`)
Python packages for PyPI. Tagged with `python-package-name-vX.Y.Z`.

## Release Process

Each package type has its own GitHub Actions workflow that triggers on specific tag patterns:

- **Helm**: Automatically released when changes are pushed to `charts/` on main branch
- **Go**: Tag with `go/module-name/vX.Y.Z`
- **Rust**: Tag with `rust-crate-name-vX.Y.Z`
- **Node.js**: Tag with `nodejs-package-name-vX.Y.Z`
- **Python**: Tag with `python-package-name-vX.Y.Z`

## Using Helm Charts

Once published, add this repository:

```bash
helm repo add homelab https://[your-username].github.io/homelab-helm
helm repo update
helm install my-app homelab/my-app
```

## Development

### Adding a New Helm Chart

```bash
cd charts/
helm create my-new-chart
# Edit chart as needed
helm lint my-new-chart
```

### Adding a New Go Module

```bash
mkdir -p go/my-module
cd go/my-module
go mod init github.com/[your-username]/homelab-helm/go/my-module
```

### Adding a New Rust Crate

```bash
mkdir -p rust/
cd rust/
cargo new my-crate --lib
```

### Adding a New Node.js Package

```bash
mkdir -p nodejs/my-package
cd nodejs/my-package
npm init
```

### Adding a New Python Package

```bash
mkdir -p python/my-package
cd python/my-package
# Create setup.py or pyproject.toml
```

## Required GitHub Secrets

Configure these secrets in your GitHub repository settings:

- `NPM_TOKEN`: NPM authentication token for publishing
- `CARGO_TOKEN`: Crates.io API token for Rust packages
- `PYPI_TOKEN`: PyPI API token for Python packages (if adding Python workflow)
- `GITHUB_TOKEN`: Automatically provided by GitHub Actions

## License

[Your License Here]