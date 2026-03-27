# Fluid

A motion experiment. Nothing more, nothing less. 🌊

## What's This?

A Flutter music feed demo I built to push the animation system as far
as it would go. Fluid page transitions, Hero animations, collapsing
headers, spring physics — all working together.

But the real reason this exists: I kept hitting a wall with Flutter's
`OpenContainer`. It uses `ModalRoute`, which completely blocks `Hero`
animations. Most people just pick one or the other. I took
`OpenContainer` apart instead.

## The Cool Technical Bit

Flutter's `OpenContainer` and `Hero` are architecturally incompatible
out of the box — `OpenContainer` runs on `ModalRoute`, and `Hero` only
works across `PageRoute` transitions. You genuinely cannot use them
together without modifying something.

So I rebuilt `OpenContainer` from scratch as `FluidWidget`, backed by
a custom `FluidPageRoute` that extends `PageRoute` instead. Now you
get both: shape-morphing container transitions *and* Hero animations
firing across the same route boundary.

The transition pipeline:

1. `FluidWidget` captures the card's position and shape on tap
2. A spring scale-down plays (`Sprung` curve), then `FluidPageRoute`
   is pushed
3. The route simultaneously morphs shape (`ShapeBorderTween`),
   position (`RectTween`), and opacity (`FlippableTweenSequence`)
4. Hero widgets animate freely — background, title, avatar, buttons,
   all of them — because we're on a real `PageRoute`
5. `HideAble` keeps the source card's space reserved in the list
   without rendering it, so there's no layout jump

`FlippableTweenSequence` is a small thing I'm proud of too — it
reverses the tween weight order on pop, so mid-animation interrupts
(the user swiping back immediately) play correctly without defining
two separate sequences.

Key files if you want to dig in:

- `lib/widgets/fluid_widget.dart` — the rebuilt OpenContainer
- `lib/core/fluid_page_route.dart` — shape + fade route transitions
- `lib/core/flippable_tween_sequence.dart` — reversible tween sequences
- `lib/core/hide_able.dart` — visibility during transitions

## ⚠️ iPhone 16 Simulator Only

I was too lazy to make it responsive. The UI is sized for iPhone 16
and it'll look off on anything else. This is a motion experiment,
not a product — responsive layout wasn't the point.

## The Asset Struggle Was Real

I spent way too long sourcing and editing everything in `assets/`.
Music covers, profile pictures, video backgrounds — who knew it'd be
this hard to find decent assets in 2025. You're welcome. 😅

## Tech Stack

- **Framework**: Flutter (SDK ^3.8.0)
- **Spring physics**: sprung — scale-down tap feedback and slide-ins
- **Animations**: flutter_animate (supplementary, declarative chains)
- **State**: flutter_bloc (just Cubit — coordinates header visibility
  between screens)
- **DI**: get_it — shares one PostCubit instance across both screens
- **Video**: video_player — looped, muted background video on cards
- **Icons**: flutter_svg — all custom icons are SVG assets

## Project Structure

```
lib/
├── core/           # The real work lives here — FluidPageRoute,
│                   # FlippableTweenSequence, HideAble
├── cubit/          # PostCubit — show/hide header state
├── models/         # Post, Song, mock data
├── screens/        # Home feed + detail screen
└── widgets/        # FluidWidget + everything else
```

## Known Limitations

Demo code is honest code:

- Song list items do nothing on tap — no audio wired up
- The mute button is cosmetic — there's no audio engine
- Video only plays on feed cards, not in the detail screen
- Everything is hardcoded mock data — no API, no persistence
- `animations` package is listed as a dependency but barely used —
  it was the reference before I replaced it

## Installation

```bash
git clone https://github.com/Lukas-io/fluid.git
cd fluid
flutter pub get

# iOS
cd ios && pod install && cd ..
flutter run
```

iPhone 16 simulator recommended.

## Gotchas

- The `animations` package is there but don't use its `OpenContainer`
  with Hero — that's the whole problem this project solves

---

**Fluid** — motion, not decoration.