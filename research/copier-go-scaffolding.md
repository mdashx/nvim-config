# Copier for Go Project Scaffolding

## Overview
**Copier** is a modern Python-based project templating tool. It's simpler and more flexible than Yeoman, with strong Go support.

**Why Copier for Go:**
- YAML-based configuration (simple, readable)
- Jinja2 templating (powerful but not bloated)
- Single-file templates or full directory structures
- Great for monorepos and multiple variants
- Lightweight (Python, not Node-dependent)

---

## Setup

### Installation
```bash
pip install copier
# or
brew install copier
```

### Basic Usage
```bash
# Create project from template
copier copy https://github.com/user/go-template ~/myproject

# Update existing project from template
copier update ~/myproject
```

---

## Typical Go Project Layouts

### 1. CLI Tool Layout
**Structure:**
```
my-cli/
├── cmd/
│   └── mycli/
│       └── main.go
├── internal/
│   ├── commands/
│   └── config/
├── go.mod
├── go.sum
├── Makefile
├── README.md
└── .gitignore
```

**Copier Template (copier.yml):**
```yaml
_templates_suffix: .jinja

project_name:
  type: str
  help: Project name (lowercase, no spaces)

description:
  type: str
  help: Brief description of CLI tool

github_user:
  type: str
  help: GitHub username (for import paths)

_copy:
  - unless: "{{ is_test }}"
    include:
      - "*.go.jinja"
      - "cmd/**"
      - "internal/**"
      - "Makefile"
```

**Template Files:**
```
go-cli-template/
├── cmd/{{ project_name }}/
│   └── main.go.jinja
├── internal/commands/
│   └── root.go.jinja
├── Makefile.jinja
├── README.md.jinja
├── go.mod.jinja
└── copier.yml
```

**Example go.mod.jinja:**
```
module github.com/{{ github_user }}/{{ project_name }}

go 1.26

require (
    github.com/spf13/cobra v1.7.0
)
```

---

### 2. Web Service Layout
**Structure:**
```
my-api/
├── cmd/
│   └── server/
│       └── main.go
├── internal/
│   ├── api/
│   │   ├── handlers/
│   │   └── middleware/
│   ├── models/
│   ├── repository/
│   └── config/
├── migrations/
├── scripts/
├── docker/
│   └── Dockerfile.jinja
├── go.mod
├── Makefile
└── README.md
```

**Copier Questions:**
```yaml
project_name:
  type: str
  default: my-api

db_type:
  type: str
  help: Database type
  choices:
    - postgres
    - mysql
    - sqlite

add_docker:
  type: bool
  default: true
  help: Include Docker setup?

add_migrations:
  type: bool
  default: true
  help: Include migration framework?
```

**Conditional Copy:**
```yaml
_copy:
  - unless: "{{ not add_docker }}"
    include:
      - "docker/**"
  
  - unless: "{{ not add_migrations }}"
    include:
      - "migrations/**"
```

---

### 3. Library Layout
**Structure:**
```
my-lib/
├── pkg/
│   └── mylib/
│       ├── core.go
│       ├── core_test.go
│       └── examples_test.go
├── internal/
│   └── helpers/
├── examples/
├── docs/
├── go.mod
├── Makefile
├── README.md
└── .github/
    └── workflows/
        └── test.yml.jinja
```

**Copier Config:**
```yaml
project_name:
  type: str

add_github_actions:
  type: bool
  default: true

go_versions:
  type: str
  help: "Go versions to test (comma-separated)"
  default: "1.24,1.25,1.26"
```

---

### 4. Monorepo Layout
**Structure:**
```
my-monorepo/
├── services/
│   ├── api/
│   │   ├── cmd/
│   │   └── internal/
│   ├── worker/
│   │   └── ...
│   └── cli/
│       └── ...
├── shared/
│   ├── models/
│   └── config/
├── go.work
├── Makefile
└── README.md
```

**Copier with Sub-templates:**
```yaml
project_name:
  type: str

services:
  type: str
  help: "Services to include (comma-separated)"
  choices:
    - api
    - worker
    - cli

include_shared:
  type: bool
  default: true
  help: Include shared package?

_copy:
  # Always copy base
  - include:
      - "go.work.jinja"
      - "Makefile"
  
  # Copy requested services
  - when: "{{ 'api' in services.split(',') }}"
    include:
      - "services/api/**"
  
  - when: "{{ 'worker' in services.split(',') }}"
    include:
      - "services/worker/**"
```

---

## Example: Building a CLI Template

### Step 1: Create Template Directory
```bash
mkdir -p go-cli-template/{cmd,internal,migrations}
cd go-cli-template
```

### Step 2: Create copier.yml
```yaml
_templates_suffix: .jinja

project_name:
  type: str
  help: Project name
  validator: "{% if project_name|length < 3 %}Name must be 3+ chars{% endif %}"

description:
  type: str
  help: Project description

github_user:
  type: str
  help: GitHub username

use_cobra:
  type: bool
  default: true
  help: Use Cobra for CLI framework?

_copy:
  - unless: "{{ not use_cobra }}"
    include:
      - "cmd/**"
```

### Step 3: Template Files
**cmd/{{ project_name }}/main.go.jinja:**
```go
package main

import (
	"fmt"
	"github.com/{{ github_user }}/{{ project_name }}/internal/commands"
)

func main() {
	// {{ description }}
	if err := commands.Execute(); err != nil {
		fmt.Println(err)
	}
}
```

**go.mod.jinja:**
```
module github.com/{{ github_user }}/{{ project_name }}

go 1.26
{% if use_cobra %}
require github.com/spf13/cobra v1.7.0
{% endif %}
```

### Step 4: Use Template
```bash
copier copy /path/to/go-cli-template ~/my-new-cli
# Prompts for: project_name, description, github_user, use_cobra
```

---

## Copier vs Alternatives

| Tool | Language | Flexibility | Go Support | Learning Curve |
|------|----------|-------------|-----------|-----------------|
| Copier | Python | High | Excellent | Low |
| Yeoman | Node | Very High | Good | Medium |
| Cookiecutter | Python | High | Good | Low |
| go-scaffold | Go | Medium | Native | Low |
| Cobra/CLI Generators | Go | Low | Native | Very Low |

---

## Best Practices

### 1. Version Templates
```yaml
_min_copier_version: "9.0"
_version: "1.0.0"
```

### 2. Provide Defaults
```yaml
github_user:
  type: str
  default: "{{ env.get('GITHUB_USER', 'yourusername') }}"
```

### 3. Validate Input
```yaml
project_name:
  validator: "{% if not project_name.islower() %}Must be lowercase{% endif %}"
```

### 4. Use Jinja2 Filtering
```yaml
_copy:
  - include:
      - "**/*.go.jinja"
  - exclude:
      - "*_test.go.jinja"  # Only if excludes needed
```

---

## Recommended Go Templates to Create

1. **go-api** — REST API with database, migrations, docker
2. **go-cli** — CLI tool with Cobra, tests, examples
3. **go-lib** — Library with CI/CD, docs, examples
4. **go-micro** — Microservice with logging, metrics
5. **go-monorepo** — Multi-service setup

---

## Integration with Your Setup

1. Create templates in `~/projects/templates/go-*`
2. Add Makefile shortcuts:
```makefile
template-cli:
	copier copy ~/projects/templates/go-cli ~/$(PROJECT)

template-api:
	copier copy ~/projects/templates/go-api ~/$(PROJECT)
```

3. Consider sharing templates in a GitHub org

---

## Resources
- [Copier Documentation](https://copier.readthedocs.io/)
- [Jinja2 Template Guide](https://jinja.palletsprojects.com/)
- [Example Go Templates](https://github.com/topics/copier-template)
