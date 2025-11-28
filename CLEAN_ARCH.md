Clean Architecture layout for UAS Social (Phase 1)

High-level folders under `lib/`:

- `src/core/` - App-level utilities like routing, DI, constants
- `src/theme/` - Theme data and color schemes
- `src/presentation/` - UI layer (pages, widgets, viewmodels/providers)
  - `pages/` - Screens (e.g., auth, home, profile)
  - `widgets/` - Reusable widgets
- `src/domain/` - Business logic, entities, repositories (interfaces)
  - `entities/`
  - `repositories/`
- `src/data/` - Data sources and implementations for repositories
  - `datasources/`
  - `repositories/`

Guidelines:
- Keep UI agnostic from data sources by coding to repository interfaces in `domain/`.
- Use Riverpod for state and dependency injection.
- Use Freezed + json_serializable for data classes and models.
- Place feature folders inside `presentation/` when the feature grows.

This file documents the starting layout. Additional folders and files will be created per feature.
