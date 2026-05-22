# TaoPulse — Pulse Feed Screen Specification

# Purpose

Pulse Feed is the primary home screen of TaoPulse.

Its purpose is to give users instant awareness of important activity across the Bittensor ecosystem through:

* realtime updates
* AI-generated summaries
* high-signal ecosystem intelligence

The screen should feel:

* fast
* alive
* intelligent
* minimal
* mobile-native

Not like:

* a blockchain explorer
* raw logs
* noisy dashboards

---

# Primary User Goal

Users should open the app and instantly understand:

* what changed
* why it matters
* what deserves attention right now

within seconds.

---

# Screen Structure

## Layout Hierarchy

```text
------------------------------------------------
Top App Bar
------------------------------------------------
Quick Filters / Feed Tabs
------------------------------------------------
Live Feed List
------------------------------------------------
Bottom Navigation
------------------------------------------------
```

---

# 1. Top App Bar

## Purpose

Provides identity, global actions, and quick access.

---

## Components

### Left

* TaoPulse logo/icon

### Center

* “Pulse Feed”

### Right Actions

* Search icon
* Notifications icon
* Settings shortcut

---

# 2. Feed Filter Bar

Horizontal scrollable chips.

## Default Filters

* All
* Subnets
* Stake
* Validators
* Governance
* GitHub
* AI Insights

---

## Additional Filter Controls

### Watchlist Toggle

Show only tracked:

* subnets
* validators
* miners

---

### Priority Filter

* High
* Medium+
* All

---

# 3. Feed List

Main vertical realtime event stream.

The feed should:

* auto-refresh
* insert newest events at top
* support infinite scrolling
* remain lightweight and smooth

---

# Feed Card Design

Each event is displayed as a compact card.

---

# Feed Card Layout

```text
------------------------------------------------
[ICON] Category               2m ago
Headline Summary
AI explanation / insight

[metadata chips]

(optional mini metrics row)
------------------------------------------------
```

---

# Card Components

## A. Event Header

### Left

Event category icon.

Examples:

* 📈 subnet movement
* 🐋 whale stake
* ⚡ validator activity
* 🚨 high priority
* 🤖 AI insight
* 🛠 GitHub update

---

### Right

Relative timestamp.

Examples:

* 1m ago
* 14m ago
* 2h ago

---

# B. Headline Summary

Short high-signal summary.

## Examples

* “Subnet 15 emissions increased 12%”
* “Whale staked 28k TAO into SN8”
* “Validator redistributed weights aggressively”
* “New miner release published”

---

# C. AI Insight Section

Most important differentiator.

Small AI-generated explanation below headline.

## Examples

> “This may increase miner competition inside SN15.”

> “Stake concentration toward one validator increased sharply today.”

> “The subnet appears to be gaining ecosystem momentum.”

---

## UX Rules

### Keep concise

Maximum:

* 1–2 lines

### Easy to scan

Avoid:

* technical jargon
* blockchain terminology overload
* long paragraphs

---

# D. Metadata Chips

Compact contextual pills.

## Examples

* SN15
* +28k TAO
* High Impact
* Validator #4
* 12 miners affected

---

## Chip Style

* rounded
* compact
* low visual weight
* monochrome/minimal

---

# E. Optional Mini Metrics Row

Only for important events.

Examples:

* emission delta
* validator rank movement
* stake percentage change

---

# Feed Event Types

# 1. Subnet Events

## Examples

* emission changes
* subnet registration
* validator weight shifts
* subnet activity spikes

---

# 2. Stake Movement

## Examples

* whale staking
* large unstaking
* validator delegation changes

---

# 3. Validator Intelligence

## Examples

* rank movement
* trust changes
* unusual validator behavior

---

# 4. Ecosystem News

## Examples

* GitHub releases
* governance proposals
* subnet launches
* important announcements

---

# 5. AI Insights

AI-generated ecosystem observations.

Examples:

* “Subnet 19 momentum increased rapidly this week.”
* “Validator concentration is becoming unusually high.”

---

# Feed Prioritization

The feed should prioritize:

* importance
* ecosystem impact
* unusual behavior

NOT:

* chronological spam

---

# Priority Levels

## High

Critical ecosystem activity.

Examples:

* major stake movement
* emission shifts
* validator instability

---

## Medium

Important but not urgent.

---

## Low

Informational updates.

---

# Feed Behavior

# Realtime Updates

## Requirements

* lightweight polling or websocket
* smooth insertion animations
* no aggressive reloading

---

# Pull To Refresh

Standard mobile refresh behavior.

---

# Smart Deduplication

Avoid repetitive spam.

Instead of:

* 20 validator update events

Aggregate into:

> “Validator performed major redistribution affecting 18 miners.”

---

# Empty State

When no events exist:

```text
No major ecosystem activity detected yet.
Realtime updates will appear here.
```

---

# Loading State

Use:

* skeleton cards
* shimmer loading

Avoid:

* blocking spinners

---

# Feed Detail Screen

Tap event → open detailed event page.

---

# Detail Page Includes

## Full Event Explanation

Expanded AI summary.

---

## Related Data

* subnet
* validator
* stake movement
* historical comparison

---

## Charts

Simple lightweight charts only.

Examples:

* emission trend
* stake flow
* validator rank trend

---

## Source References

Links to:

* GitHub
* explorer
* TaoStats-like sources

---

# UX Philosophy

Pulse Feed should feel like:

> “Realtime ecosystem intelligence.”

not:

> “raw blockchain telemetry.”

---

# Design Style

## Visual Direction

* dark-first
* minimal
* modern fintech aesthetic
* high information density
* clean spacing

---

# Animation Style

Subtle only.

Examples:

* fade-in feed items
* smooth card expansion
* gentle refresh transitions

Avoid:

* flashy crypto UI
* excessive motion

---

# MVP Scope

## Include

✅ realtime feed
✅ AI summaries
✅ subnet events
✅ stake movement
✅ ecosystem news
✅ filtering
✅ watchlist mode
✅ feed detail screen

---

## Exclude Initially

❌ deep analytics
❌ advanced charting
❌ social sentiment
❌ prediction engine
❌ portfolio tracking
❌ trading features

---

# Success Criteria

The feed succeeds if users feel:

> “I immediately know what matters in Bittensor today.” 🚀
