#!/bin/bash

# Bootstrap script - install dependencies in all packages

echo "🚀 Bootstrapping workspace..."
echo ""

# Root project
echo "📦 Installing dependencies in root..."
flutter pub get
echo ""

# Find all packages and run pub get
echo "📦 Installing dependencies in packages..."
find packages -name "pubspec.yaml" -type f | while read pubspec; do
    dir=$(dirname "$pubspec")
    echo "  └─ $dir"
    (cd "$dir" && flutter pub get > /dev/null 2>&1)
done

echo ""
echo "✅ Bootstrap complete!"
