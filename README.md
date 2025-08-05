# Fluid

A Flutter music app demo showcasing fluid animations and some cool technical solutions I figured out.

## What's This?

Just a demo app I built to explore fluid motion designs in Flutter. It's got some nice animations, music post interactions, and I solved an interesting technical challenge along the way.

## The Cool Technical Bit

**The main thing I'm proud of**: I restructured the OpenContainer from the `animations` package to work with Hero widgets. 

Here's what I did:
- The original OpenContainer uses a ModalRoute, but I needed it to work with my custom `FluidPageRoute`
- I basically took the OpenContainer code and modified it to use a PageRoute instead of ModalRoute
- This enabled Hero animations to work seamlessly with the OpenContainer animations

Check out `FluidWidget` in the code - it's basically OpenContainer but restructured. The key change was switching from ModalRoute to PageRoute in the route configuration.

**Why this matters**: Without this restructuring, you can't use Hero widgets with OpenContainer animations. Now you get both smooth page transitions AND Hero animations working together.

## Running This Thing

### Prerequisites
- Flutter SDK
- **iPhone 16 Simulator** (read the important note below)

### Quick Start
```bash
git clone <repo>
cd fluid
flutter pub get
flutter run
```

## ⚠️ Important: Use iPhone 16 Simulator

**This is just a demo and I was too lazy to make it responsive.** 

The UI is hardcoded for iPhone 16 dimensions. If you run it on anything else, it'll probably look weird or broken. Don't expect responsive design - this is purely a demo/prototype.

## What's Inside

- **Fluid animations** with custom page routes
- **Hero widget transitions** (thanks to that OpenContainer restructuring)
- **Music post interface** with video/audio
- **Custom app bars** with gradient overlays
- **State management** with Cubit

## The Asset Struggle is Real

**PSA**: I spent way too long finding and editing all the images and videos in the `assets/` folder. Who knew it's so hard to find and edit images nowadays? 😅 The music covers, profile pics, and video content took forever to source and format properly.

## Project Structure
```
lib/
├── core/           # Theme, assets, custom page routes
├── cubit/          # State management
├── models/         # Data models
├── screens/        # Main screens
└── widgets/        # UI components (including that FluidWidget)
```

## Key Files to Check Out

- `lib/widgets/fluid_widget.dart` - The restructured OpenContainer
- `lib/core/fluid_page_route.dart` - Custom page route for smooth transitions
- `lib/widgets/music_post_item.dart` - Hero animations in action

## Tech Stack

- Flutter
- Bloc/Cubit for state management
- Custom animations package (modified)
- Hero widgets
- Custom fonts

---

**Bottom line**: This is a demo showcasing fluid animations and solving the OpenContainer + Hero widget challenge. Use iPhone 16 simulator, don't expect responsive design, and check out that FluidWidget if you're curious about the technical solution! 🚀
