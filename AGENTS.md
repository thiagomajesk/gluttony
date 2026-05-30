# Workflow

- Never silently fill in ambiguous requirements
- Never act on question, provide insights and wait for resolution.
- Prefer the simplest possible solution that could reasonably work
- Think like a boy scout, leave the place better than you found it
- Start with a naive, obviously correct implementation before optimizing
- Push back on incorrect, risky, or poorly-scoped instructions and propose safer or simpler alternatives

## Code style

### General

- When semantic permits (without changing behavior), organize code by grouping logically related elements (and splitting unrelated ones). Arrange lines that looks visually balanced and easy to scan. Mind variables and functions width. Notice that often times, organization can be done by simply using newlines or re-arranging the code so that statements compose a clear "visual rhythm".
- This is not a Typescript codebase, so avoid leaking unrelated idioms into Elixir code. For instance, patter matching (structs and guards) should never be used to emulate a type-system, specially when the shape of the data is known up front (or otherwise enforced from the flow). Use pattern-matching when differentiating clauses based on the shape of the data makes sense and communicates intent clearly. You must also avoid using defensive programming at all costs and should prefer to embrace the "let is crash" philosophy.

### Elixir

- Prefer `alias __MODULE__` instead of referencing `%__MODULE__{}` directly.
- Avoid wrapping existing Elixir/OTP primitives in abstraction modules for safety.
- Avoid pipes for single function calls, prefer: `new(Application.fetch_env!(...))`.
- Prefer returning tuples inline (e.g., `{repo.insert!(record), value}`) over separate statements.
- Avoid unnecessary block-level comments that separate "sections" of a given module
- Use `get_in/2` for safe nested access (e.g., `get_in(scope.user.id)` instead of conditional access).
- Inline `if` and `with` when short/single line results, eg: `if ..., do: ..., else: ...` / `with ..., do: {:ok, result}`
- Ensure functions are ordered as: public functions first (sorted alphabetically) and private functions last (sorted by calling order)
- Remember that `with` only requires `else` if you want to modify the failure case result (since it automatically returns that)

### Phoenix/ LiveView

- Prefer using the new HEEx directives when possible (i.e: `:for` and `:if`)
- A LiveView's first function should always be `render`, followed up by `mount` and the others.
- Component modules needs a `use WonderfallWeb, :html` to ensure the html helpers are imported.

- Avoid creating additional variables in conditionals, you may use expressions:
    `<span :if={name = Map.get(@entity, :name)}>{name}</span>`.
- Avoid creating conditional styling in components, you may also use data attributes:
    `<i data-valid={@valid} class="data-valid:text-green-500" />`.
- Avoid creating complexity with component variants, you may also use a private function such as:
    `<span class={["text-green-500", tooltip_type_classes(@type)]}></span>`.

### Ecto

- Ecto queries should use initials for bindings to make the query more compact
- Ecto queries keyword-based syntax should be preferred over the macro-based syntax

### HTML/CSS/Javascript

- Prefer semantic HTML when possible
- Avoid nesting HTML to increase readability
- Avoid using `@apply` in ordinary CSS unless explicitly requested. Small DaisyUI overrides or reusable component classes may use it when it reduces repeated utility strings.
- Don't write inline <script>custom js</script> tags within templates
- Use kebab case for Javascript and CSS file names (eg: this-is-my-file)
- Prefer DaisyUI classes and Tailwind utilities over custom CSS.
- Write custom Tailwind-based components only when DaisyUI does not provide a fitting primitive.
- Use `style` exclusively for setting CSS variables dynamically and not for actual styling

### DaisyUI

- Use DaisyUI default components first for a consistent look and feel before creating custom ones.
- Extend DaisyUI components with small Tailwind utility overrides before writing custom component CSS.
- When a pattern should repeat across the app, express it as theme tokens, DaisyUI variants, or a small reusable component instead of page-scoped CSS.
- Keep page-specific CSS for page-specific effects only, such as landing-page backgrounds, previews, or decorative motion.
- Use `rounded-box`, `rounded-field` and `rounded-selector` to keep theming consistent when possible.
- Prefer semantic DaisyUI theme colors (`base-*`, `primary`, `accent`, `neutral`, and matching `*-content`) over fixed Tailwind colors when the style should survive theme changes.
- Use fixed Tailwind colors only for illustrations, brand marks, category accents, or assets that intentionally should not follow the theme.
- Remember you can use the `base-*` classes to create proper elevation (eg: `bg-base-100`), stack translucent surfaces (eg: `bg-base-content/5` / `bg-base-300/30`), or define less fuzzy borders (eg: `border-base-content/10`).

## UI/UX & design

- Ensure clean typography, spacing, and layout balance for a refined, premium look
- Implement subtle micro-interactions (e.g., button hover effects, and smooth transitions)
- Focus on delightful details like hover effects, loading states, and smooth page transitions
- Produce world-class UI designs with a focus on usability, aesthetics, and modern design principles
- Ensure layouts are accessible by checking against Tailwind CSS breakpoints (sm, md, lg, xl, 2xl)

## Testing

- Prefer to use `refute` instead of `assert value == nil`.
- Don't write tests for trivial implementation details, focus on high-level functionality.
- Use the pin operator for matching known values (e.g., `assert %{id: ^id} = result`).

## Refactoring

When editing code, aways preserve the original semantics. Before editing, think: What's the simplest possible diff that achieves the same result Avoid meaningless refactors such as variable or function names changes without prior confirmation. Also, never mix behavior (what the code achieves) and structural (how the code achieves) changes. Here's a non-exhaustive list of examples to avoid:
  - Droping pre-existing variables
  - Inlining code while altering behavior
  - Renaming variables while fixing a bug
  - Reformatting code while adding a new feature
  - Extracting a function while changing its logic
  - Moving files/modules while modifying functionality

## Documentation

### General

- Use hyphens instead of em-dashes for documentation
- Ensure /docs are kept up to date with the current state of the codebase.
- Write prose that is direct and addresses the reader without over-explaining.
- ASCII diagrams are welcome for architecture and data-flow explanations.
- Components documentation should always have 3 sections:
  - Options: Documents available options (attrs)
  - Styling: Documents styling options (data attributes)
  - Examples: Documents how to use components (non comprehensive)

### Elixir-specific

- Lead every doc with a single sentence, then expand with context below.
- Keep examples practical and compact, demonstrating real use cases of usage.
- Document options as a bullet list as: `* name - description` and include enough detail about the option at hand.
- Use `##` headers to break module docs into logical sections when a module covers multiple concepts.
- Cross-reference related modules with backtick links (e.g., "See `Module.function/2` for more details.").
- Don't document the obvious, if a function's name and typespec make the behavior clear, a one-liner is enough.
