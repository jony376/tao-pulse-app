# Contributing to TaoPulse

Thanks for contributing to TaoPulse.

This project is developed in public. Contributions are welcome for the Flutter app, design improvements, bug fixes, docs, and developer tooling.

## Ways to Get Involved

- Open an issue for bugs, product feedback, or feature ideas.
- Join GitHub discussions to ask questions or discuss product direction.
- Open a pull request for focused improvements that align with the project direction.
- Read the README first to understand TaoPulse and the main Bittensor concepts used in the product.

## Development Setup

Install Flutter using the official guide:
https://docs.flutter.dev/get-started/install

After Flutter is installed, verify your environment:

```bash
flutter doctor
```

From the Flutter app directory, install dependencies:

```bash
cd taopulse
flutter pub get
```

Run the app on a connected device or emulator:

```bash
flutter run
```

Useful commands:

```bash
flutter analyze
flutter build apk --debug
flutter build apk --release
```

API docs for app-facing testing: https://icodex.space/docs

Notes:

- Use the Flutter app directory as the working directory for Flutter commands.
- Make sure an emulator or physical device is available before running the app.
- If you change dependencies, run `flutter pub get` again.


## Contribution Guidelines

- Discuss medium or large changes before implementation.
- Align changes with the README vision, roadmap, and product direction.
- Match the existing structure, naming, and architectural patterns.
- Keep UI changes clear, calm, and mobile-first.
- Avoid unrelated refactors in the same pull request.
- Prefer small, focused changes over broad mixed updates.
- Update documentation when behavior, setup, or contributor workflow changes.
- If a change requires API or mock data changes for the app, request it explicitly and explain why.
- AI coding tools are allowed, but contributors are responsible for guiding and reviewing the work carefully.
- Low-quality, unsupervised, or random AI-generated contributions may be rejected.

### Labels

Labels are used to make triage and roadmap alignment clearer.

- `needs-discussion`: the idea needs product or design discussion before implementation
- `accepted-design`: the direction is approved and ready for focused implementation
- `blocked`: the work is waiting on clarification or dependency changes
- `good-first-issue`: the issue is suitable for a first contribution
- `maintainer-only`: the work is sensitive, high-risk, or reserved for maintainers

### Pull Requests

When opening a pull request:

- link the issue or discussion that approved the work
- explain what changed
- explain why it changed
- include screenshots for UI changes when relevant
- list the testing or validation you ran

### Issues

For bug reports, include:

- expected behavior
- actual behavior
- reproduction steps
- screenshots or logs when relevant

For feature requests, include:

- the user problem
- the expected outcome
- why the change matters
