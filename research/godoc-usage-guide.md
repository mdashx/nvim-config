# godoc.nvim Usage Guide

## Quick Start

### Basic Usage
1. Open a Go file
2. Press `<leader>go` to open godoc search
3. Type package name (e.g., `fmt`, `encoding/json`)
4. Select result to view documentation

### Symbol Search
Press `<leader>gO` to search for:
- Function names
- Type definitions
- Constants/variables

Example: Standing on `fmt.Println` usage, `<leader>gO` shows Println docs.

## Common Workflows

### Workflow 1: Quick Lookup (Cursor-based)
```go
// You're writing HTTP server code
http.ListenAndServe(":8080", nil)
      ↑ cursor here
    Press <leader>gO (capital O)
    Godoc instantly searches for "ListenAndServe"
    View documentation without typing
```

### Workflow 2: Exploring Standard Library
```go
// You're writing HTTP server code
http.ListenAndServe(":8080", nil)
      ↑
    Press <leader>go
    Type "http" to search http package
    View http package docs
    Discover http.Handler, http.Server, etc.
```

### Workflow 2: Learning Third-Party API
```go
// Using a new package
ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
                        ↑
                    Press <leader>gO
                    Shows WithTimeout signature
                    View full docs
                    Examples in stdlib
```

### Workflow 3: Type Discovery
```go
var buf bytes.Buffer
        ↑
    Press <leader>gO
    View Buffer methods
    Discover ReadFrom, WriteTo, Grow, etc.
```

## Real Examples

### Example 1: JSON Marshaling
You're writing a JSON encoder but forget the struct tag syntax:

```go
type User struct {
    Name string
    // forgot the json tag format
}
```

1. `<leader>go` → search `encoding/json`
2. View JSON package docs
3. Find struct tag examples in documentation
4. Copy format: `` `json:"name"` ``

### Example 2: Error Handling
Need to wrap errors with context:

```go
if err != nil {
    // How to wrap this error?
    return err
}
```

1. `<leader>go` → search `errors`
2. Find `errors.Join()` or `fmt.Errorf()` options
3. View examples for error wrapping patterns
4. Apply to your code

### Example 3: Concurrent Programming
Forgotten how sync.WaitGroup works:

```go
var wg sync.WaitGroup
// What methods does WaitGroup have?
```

1. `<leader>gO` on `WaitGroup`
2. View: Add(), Done(), Wait() methods
3. See examples of concurrent patterns
4. Copy pattern to your code

## Tips & Tricks

### Tip 1: Go to Definition
In godoc picker, press `gd` to jump to:
- Package source location
- Type definitions
- Function implementations

Useful for diving deeper into stdlib.

### Tip 2: Keep Documentation Visible
Some users keep godoc search open in a split:
```
┌──────────────┬──────────────┐
│  Go code     │  godoc picker│
│  (editing)   │  (reference) │
└──────────────┴──────────────┘
```

Use Telescope's layout options.

### Tip 3: Search Tips
- `fmt` → fmt package
- `fmt/println` → Println function in fmt
- `*` → all stdlib packages
- `time.Duration` → Duration type in time package

### Tip 4: Three-Way Documentation Lookup
Use different tools for different needs:

**Quick hover (K):**
```go
func doSomething(ctx context.Context) error {
                 ↑ Press K for signature
```

**For packages/functions (<leader>gO):**
```go
fmt.Println("hello")
    ↑ Press <leader>gO for godoc
```

**For keywords/offline docs (<leader>gs):**
```go
if err != nil {  // Press <leader>gs on "if" for spec
    ↑
    Offline go doc in split
}
```

## Comparison: Documentation Tools

| Task | godoc.nvim | go doc (`<leader>gs`) | Hover (K) | LSP GoTo |
|------|-----------|-----------|----------|----------|
| Quick type signature | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ |
| Keywords (if, for, type) | ⭐ | ⭐⭐⭐ | ⭐ | ⭐ |
| Browse package | ⭐⭐⭐ | ⭐⭐ | ⭐ | ⭐ |
| Find examples | ⭐⭐⭐ | ⭐⭐ | ⭐ | ⭐ |
| Discover APIs | ⭐⭐⭐ | ⭐⭐ | ⭐ | ⭐ |
| Offline/No internet | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |

## Troubleshooting

**Issue:** godoc picker shows no results
- Verify `go` command works: `go version`
- Check package exists: `go list fmt`
- Restart Neovim

**Issue:** Slow search with many packages
- Normal for first run (godoc indexes packages)
- Subsequent searches are cached and fast
- Can configure package filters if needed

**Issue:** Picker not opening
- Verify Telescope is installed (in kickstart)
- Check keybindings are set correctly
- Try `:Godoc` command directly
