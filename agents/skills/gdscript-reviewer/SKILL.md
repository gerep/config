---
name: gdscript-reviewer
description: "Reviews GDScript code for style, best practices, and game dev patterns. Use when asking for code review, feedback on GDScript, or checking if code follows Godot conventions."
---

# GDScript Code Reviewer

Reviews GDScript code following official Godot style guide and game development best practices.

## Review Approach

1. **Don't rewrite the code** - Point out issues and explain why
2. **Prioritize**: Bugs > Performance > Style > Nitpicks
3. **Be constructive** - Explain the "why" behind suggestions
4. **Game dev context** - Consider if the code will work well in a real-time game loop

## Official GDScript Style Guide

Based on: https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| File names | snake_case | `yaml_parser.gd` |
| Class names | PascalCase | `class_name YAMLParser` |
| Node names | PascalCase | `Player`, `EnemySpawner` |
| Functions | snake_case | `func load_level():` |
| Variables | snake_case | `var particle_effect` |
| Signals | snake_case | `signal door_opened` |
| Constants | CONSTANT_CASE | `const MAX_SPEED = 200` |
| Enum names | PascalCase | `enum Element` |
| Enum members | CONSTANT_CASE | `{EARTH, WATER, AIR, FIRE}` |

### Code Order

```
01. @tool, @icon, @static_unload
02. class_name
03. extends
04. ## doc comment

05. signals
06. enums
07. constants
08. static variables
09. @export variables
10. remaining regular variables
11. @onready variables

12. _static_init()
13. remaining static methods
14. overridden built-in virtual methods:
    - _init()
    - _enter_tree()
    - _ready()
    - _process()
    - _physics_process()
    - remaining virtual methods
15. overridden custom methods
16. remaining methods
17. inner classes
```

Within each section: public before private.

### Formatting Rules

- **Indentation**: Use tabs (Godot default)
- **Line length**: Keep under 100 characters, prefer 80
- **Continuation lines**: Use 2 indent levels for function args, 1 for arrays/dicts
- **Comments**: Start with space (`# Comment`), no space for disabled code (`#print()`)
- **Enums**: One member per line

### Static Typing

Encourage typed code for clarity and error catching:

```gdscript
# Good
var speed: float = 100.0
var direction: Vector2 = Vector2.ZERO
func get_damage() -> int:

# Avoid
var speed = 100.0
func get_damage():
```

## Game Dev Best Practices

### Performance Considerations

- **_process vs _physics_process**: Use `_physics_process` for movement/physics, `_process` for visuals
- **Caching references**: Use `@onready` instead of repeated `get_node()` calls
- **Signal connections**: Prefer signals over polling in `_process`
- **Delta time**: Always multiply movement by `delta`

### Common Issues to Flag

1. **Missing delta**: `position += velocity` should be `position += velocity * delta`
2. **get_node in _process**: Cache with `@onready` instead
3. **Hardcoded values**: Should be `@export` or `const`
4. **Magic numbers**: Use named constants
5. **Long functions**: Break into smaller, focused functions
6. **Deeply nested code**: Suggest early returns or state machines
7. **Unused variables**: Remove or use
8. **Public vars that should be private**: Prefix with `_`

### Scene/Node Patterns

- **Tight coupling**: Warn if script assumes specific parent/sibling structure
- **Direct node paths**: Fragile; suggest signals or groups
- **Autoload overuse**: Suggest alternatives when appropriate

## Review Output Format

Structure reviews as:

### 🔴 Critical (Bugs/Errors)
Issues that will cause problems at runtime.

### 🟡 Improvements
Performance, maintainability, or pattern issues.

### 🔵 Style
Naming, formatting, code order issues.

### ✅ What's Good
Acknowledge what's done well.

## When Reviewing

1. Read the full code first
2. Understand the intent before critiquing
3. Ask clarifying questions if context is missing
4. Suggest, don't demand
5. Offer to explain any suggestion in more depth
