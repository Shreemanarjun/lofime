# 🎧 lofime

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Jaspr](https://img.shields.io/badge/Jaspr-0.22.0-blue.svg)](https://jaspr.dev)
[![Live Demo](https://img.shields.io/badge/demo-lofi.shreeman.dev-purple.svg)](https://lofi.shreeman.dev)

> A premium, single-page lo-fi sanctuary for deep work and late-night vibes. Built with Jaspr, bringing the soul of Bollywood chill to your browser.

![Lofime Screenshot](https://img.shields.io/badge/Status-Production%20Ready-brightgreen)

## ✨ Features

### 🎵 **Immersive Audio Experience**
- **HD YouTube Streaming**: Seamlessly play curated lo-fi Bollywood tracks directly from YouTube
- **Smart Discovery**: Auto-discover new tracks or search for your favorite artists
- **Infinite Playback**: Autoplay mode keeps the vibes flowing endlessly

### 💾 **Personal Library**
- **Local Persistence**: Save your favorite tracks to browser storage—no account needed
- **Offline Access**: Your favorites persist across sessions, always ready when you return
- **Quick Library Access**: Toggle between discovery and your personal collection instantly

### 🎨 **Modern Design**
- **Glassmorphic UI**: Premium glassmorphism aesthetic with smooth animations
- **Responsive Layout**: Flawless experience on desktop, tablet, and mobile
- **Animated Background**: Deep space theme with dynamic nebula effects and starry particles
- **Single-Page Experience**: Everything you need on one seamless page

### 🎛️ **Advanced Controls**
- **Precision Playback**: Play, pause, skip, and seek with intuitive controls
- **Volume Management**: Fine-tune your listening experience
- **Real-time Progress**: Visual feedback with animated progress bars
- **Track Information**: Live metadata display for currently playing tracks

## 🚀 Getting Started

### ✅ Prerequisites

- **Dart SDK** (version `^3.10.0` or higher)
- **Jaspr CLI** (install via `dart pub global activate jaspr_cli`)

### 🛠️ Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/Shreemanarjun/lofime.git
   cd lofime
   ```

2. **Install dependencies:**
   ```sh
   dart pub get
   ```

3. **Generate code (for models):**
   ```sh
   dart run build_runner build --delete-conflicting-outputs
   ```

### 🏃 Running for Development

Start the Jaspr development server:

```sh
jaspr serve
```

The app will be available at `http://localhost:8080` with hot-reload enabled. 🔥

### 📦 Building for Production

Build the optimized production bundle:

```sh
jaspr build client
```

The compiled output will be in the `build/jaspr/` directory, ready for deployment to any static host.

## 🏗️ Tech Stack

- **[Jaspr](https://jaspr.dev)** - Modern web framework for Dart
- **[Riverpod](https://riverpod.dev)** - Robust state management
- **[dart_mappable](https://pub.dev/packages/dart_mappable)** - Type-safe JSON serialization
- **[YouTube Explode Dart](https://pub.dev/packages/youtube_explode_dart)** - YouTube metadata extraction
- **Tailwind CSS** - Utility-first styling (via jaspr_tailwind)

## 🎯 Architecture

```
lib/
├── core/
│   ├── models/          # Data models with dart_mappable
│   └── services/        # YouTube music service
├── features/
│   ├── player/          # Player controller & view
│   └── ui/              # Reusable UI components
└── pages/               # Main application pages
```

## 🌐 Deployment

Lofime is production-ready and can be deployed to any static hosting service:

- **Vercel**: `vercel --prod`
- **Netlify**: Drag & drop the `build/jaspr/` folder
- **GitHub Pages**: Push the build folder to `gh-pages` branch
- **Firebase Hosting**: `firebase deploy`

**Live Demo**: [lofi.shreeman.dev](https://lofi.shreeman.dev)

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**! ❤️

1. **Fork the Project** 🍴
2. **Create your Feature Branch** (`git checkout -b feature/AmazingFeature`)
3. **Commit your Changes** (`git commit -m 'Add some AmazingFeature'`)
4. **Push to the Branch** (`git push origin feature/AmazingFeature`)
5. **Open a Pull Request** 📬

Please ensure your code follows the project's linting rules (see `analysis_options.yaml`).

## 🐛 Known Issues & Roadmap

- [ ] Add playlist creation and management
- [ ] Implement keyboard shortcuts
- [ ] Add visualizer for audio playback
- [ ] Support for custom YouTube playlists
- [ ] Dark/Light theme toggle

## 📜 License

This project is distributed under the MIT License.

---

### The MIT License

Copyright (c) 2025 Shreeman Arjun Sahu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

---

<div align="center">

**Built with ❤️ by [Shreeman Arjun Sahu](https://shreeman.dev)**

[Portfolio](https://shreeman.dev) • [GitHub](https://github.com/Shreemanarjun) • [Live Demo](https://lofi.shreeman.dev)

</div>
