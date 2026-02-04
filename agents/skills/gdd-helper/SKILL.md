---
name: gdd-helper
description: "Helps write Game Design Documents. Use when planning a game, defining mechanics, scoping a project, or creating a GDD."
---

# Game Design Document Helper

Helps create clear, focused Game Design Documents before coding begins.

## Why GDDs Matter

- Forces you to think through mechanics before implementation
- Reveals scope issues early
- Creates a reference during development
- Helps communicate your vision

## GDD Sections

Guide the learner through these sections:

### 1. Concept (1 paragraph)
What is this game in one paragraph? Include:
- Genre
- Core mechanic
- Player fantasy/feeling
- Unique hook

**Example**: "A 2D roguelike where you play as a slime that absorbs enemy abilities. Fast-paced combat with the tension of choosing which powers to keep. The hook: you become what you eat."

### 2. Core Loop
What does the player do repeatedly?

```
[Action] → [Challenge] → [Reward] → [Progression] → repeat
```

**Example**: "Explore room → Fight enemies → Absorb ability → Choose loadout → Next room"

### 3. Mechanics List
List every mechanic. Be specific.

| Mechanic | Description | Priority |
|----------|-------------|----------|
| Movement | 8-direction, constant speed | Must have |
| Dash | Short invincible burst | Must have |
| Absorb | Touch dead enemy to gain power | Must have |
| Inventory | Hold 3 abilities max | Should have |
| Shop | Spend coins between runs | Nice to have |

### 4. Controls
Map every action to an input.

| Input | Action |
|-------|--------|
| WASD / Left Stick | Move |
| Space / A Button | Dash |
| Left Click / X Button | Attack |
| E / Y Button | Absorb |

### 5. Player Progression
How does the player get stronger?

- **Within a run**: Absorb abilities, find upgrades
- **Between runs**: Unlock new starting abilities, permanent stats

### 6. Art & Audio Direction
Brief description of the vibe:
- Art style (pixel art, hand-drawn, minimalist)
- Color palette
- Audio mood (chiptune, orchestral, ambient)

### 7. Scope & Milestones

Define what "done" looks like at each stage:

| Milestone | Contents | Time |
|-----------|----------|------|
| Prototype | Movement, 1 enemy, 1 ability | 1 week |
| Vertical Slice | 3 enemies, 5 abilities, 1 boss | 3 weeks |
| Alpha | Full loop, 10 abilities, 3 bosses | 2 months |
| Release | Polish, audio, menus, balance | 3 months |

### 8. Risks & Unknowns
What might go wrong? What do you need to figure out?

- "Not sure if absorb mechanic feels good"
- "Might be too easy/hard to balance"
- "Art style TBD"

## GDD Anti-Patterns

Warn against:

- **Too long**: If it's 20 pages, it's a novel, not a GDD
- **Too vague**: "Combat will be fun" means nothing
- **No priorities**: Everything can't be "must have"
- **No scope limits**: Leads to feature creep
- **Writing it once and forgetting**: GDD is living document

## Workflow

1. **Ask about the game idea** - Get the elevator pitch
2. **Help define core loop** - What's the repeated action?
3. **List mechanics with priorities** - Must have vs nice to have
4. **Define scope** - What's the smallest playable version?
5. **Identify risks** - What could go wrong?
6. **Suggest first milestone** - What to build this week?

## Scoping Questions

Ask these to prevent overscoping:

- "What's the ONE thing that makes this game interesting?"
- "Can you build a playable version in one week?"
- "What can you cut and still have a game?"
- "Have you built something like this before?"

## Output Format

When generating a GDD, use markdown with clear headers. Keep it to 1-2 pages max for small games.

Offer to save as a `.md` file in their project.
