# Contributing to TaoPulse

Thanks for contributing to TaoPulse.

This project is developed in public. Contributions are welcome for the Flutter app, design improvements, bug fixes, docs, and developer tooling.

## Before You Start

- Read the README to understand TaoPulse.
- Understand the main Bittensor concepts used in the product, such as subnets, miners, validators, staking, and alerts.
- Check issues, pull requests, and discussions before starting work.

## Development Setup

### Flutter app

Install Flutter using the official guide:

- https://docs.flutter.dev/get-started/install

Then run:

```bash
flutter pub get
flutter run
```

Useful checks:

```bash
flutter doctor
flutter analyze
```


## Contribution Guidelines

- Share the design and implementation approach before larger changes.
- Match the existing structure and naming conventions.
- Keep UI changes consistent with the current product direction unless the change is intentionally redesign-focused.
- Update documentation when behavior or setup changes.
- If a change requires modifying data or API responses for the app, request it explicitly and explain why.
- Avoid unrelated refactors in the same pull request.
- Keep pull requests focused and easy to review.
- Prefer small, incremental improvements over broad mixed changes.
- You may use AI coding tools, but you must guide them with a clear goal, scope, and purpose.
- Unsupervised or random AI-generated work may lead to blocked or rejected future contributions.
- Be precise and clear. Avoid unnecessary verbosity.

## Pull Requests

When opening a pull request:

- include the issue link that approved the work to proceed
- explain what changed
- explain why it changed
- include screenshots for UI changes when possible
- mention any testing or validation you ran

## Issues

Bug reports are most useful when they include:

- expected behavior
- actual behavior
- reproduction steps
- screenshots or logs when relevant

Feature requests are most useful when they explain:

- the user problem
- the expected outcome
- why the change matters