# 3. Ask AI Overview / Specification

## Purpose

**Ask AI** is the intelligence layer of TaoPulse.

Instead of manually analyzing dashboards, subnet metrics, validator behavior, GitHub updates, and stake movements, users can simply ask questions in natural language and receive concise, ecosystem-aware explanations.

Goal:

> Help users understand what is happening in Bittensor and why it matters.

---

# Core Product Identity

This is the main differentiator of TaoPulse.

Most Bittensor tools provide:

* charts
* metrics
* dashboards
* raw numbers

TaoPulse provides:

> AI-powered ecosystem understanding.

---

# Primary User Jobs

Users open Ask AI to:

1. Understand subnet activity
2. Explain stake or validator movements
3. Summarize ecosystem changes
4. Research subnet trends
5. Detect opportunities or risks
6. Learn Bittensor concepts
7. Investigate unusual events
8. Get realtime ecosystem insights quickly

---

# Core UX Philosophy

The AI should feel like:

```text
A realtime Bittensor ecosystem copilot
```

Not:

* a generic chatbot
* a coding assistant
* a broad internet AI

The AI should stay focused on:

* Bittensor
* subnets
* validators
* staking
* emissions
* governance
* ecosystem intelligence

---

# Main Screen Layout

## Top Bar

```text
Ask AI
```

Actions:

* History
* New Chat
* Profile

---

# Main AI Interface

## Chat Input

Large input area:

```text
Ask about subnets, validators, stake movement...
```

Suggested quick prompts shown above input.

---

# Suggested Prompt Chips

Examples:

```text
Why is subnet 19 moving today?
```

```text
Summarize important ecosystem events
```

```text
Which validators changed weights recently?
```

```text
Any unusual TAO stake movement?
```

```text
Explain subnet 15 activity
```

```text
What should I pay attention to today?
```

---

# AI Response Style

Responses should be:

* concise
* ecosystem-focused
* actionable
* beginner-friendly
* source-grounded
* not overly verbose

Good response style:

```text
Subnet 19 emissions increased 4.2% today after several validators adjusted weights toward higher-performing miners. Stake inflow also increased by 18K TAO over the last 12 hours.
```

Bad response style:

* long generic essays
* vague speculation
* excessive technical jargon without explanation

---

# Key AI Features

## 1. Ecosystem Q&A

Users ask anything naturally.

Examples:

* “What changed today?”
* “Why is subnet 8 trending?”
* “What is causing validator movement?”
* “Explain TAO emissions.”
* “Which subnet has unusual activity?”

---

## 2. Realtime Feed Summarization

AI summarizes important ecosystem activity.

Example:

```text
Today’s major events:
- Subnet 19 emissions increased sharply
- Large TAO stake moved into subnet 8
- Validator activity increased across AI inference subnets
- New GitHub release published for opentensor/bittensor
```

---

## 3. Subnet Analysis

AI explains:

* subnet purpose
* recent activity
* growth trends
* risks
* validator behavior
* miner competition

Example:

```text
Subnet 15 currently shows winner-take-all behavior with concentrated validator weighting toward a single miner.
```

---

## 4. Wallet / Stake Analysis

Users paste:

* wallet address
* hotkey
* validator

AI explains:

* stake movement
* participation
* subnet exposure
* notable activity

---

## 5. Event Explanation

Every feed item should support:

```text
[Ask AI]
```

Example:

User taps:

> “Large validator weight shift detected”

AI explains:

* what happened
* why it matters
* possible ecosystem impact

This is extremely valuable.

---

# AI Context Awareness

The AI should understand:

* current ecosystem activity
* recent feed events
* watched entities
* active alerts
* user-selected subnet

This makes responses feel intelligent and personalized.

---

# Suggested Sections

## 1. Suggested Questions

At top when empty.

---

## 2. Recent Conversations

Quick re-open previous discussions.

---

## 3. Trending Topics

Examples:

```text
Trending:
- Subnet 19 emissions
- Validator rotation
- TAO whale movement
- New subnet launches
```

---

# AI Personality

Recommended tone:

* intelligent
* concise
* analytical
* calm
* practical

Avoid:

* meme tone
* excessive hype
* generic AI assistant personality

The AI should feel like:

> a professional ecosystem analyst.

---

# MVP Scope

## MVP Must Have

* Chat UI
* Suggested prompts
* Realtime feed summarization
* Subnet Q&A
* Event explanation
* AI answers based on feed data
* Conversation history

---

## MVP Nice To Have

* Wallet analysis
* Validator analysis
* Personalized AI insights
* Voice input
* Streaming responses
* AI-generated daily briefing

---

## Later Expansion

Future evolution can become:

### AI Copilot

Examples:

* “Which subnet looks strongest this week?”
* “What changed while I was asleep?”
* “Summarize validator behavior.”
* “Detect suspicious activity.”
* “Explain risks in my watched subnets.”

---

# Technical Direction

For MVP:

* LLM + structured ecosystem context
* RAG over feed/events
* subnet metadata
* validator/stake activity ingestion

No need initially for:

* autonomous agents
* advanced reasoning workflows
* portfolio optimization

Keep first version:

* fast
* concise
* reliable

---

# Final Product Definition

Ask AI is the intelligence engine of TaoPulse.

Feed tells users:

> what happened.

Ask AI explains:

> why it matters. 🚀
