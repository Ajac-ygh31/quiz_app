#!/bin/bash

echo "🧹 Iniciando limpieza total de Flutter + iOS..."

# Limpiar builds y caché de Flutter
echo "👉 Ejecutando flutter clean..."
flutter clean

echo "👉 Limpiando caché global de paquetes Flutter..."
flutter pub cache clean

# Volver a instalar dependencias de Flutter
echo "👉 Restaurando dependencias de Flutter..."
flutter pub get

# Compilar el proyecto
echo "👉 Compilando proyecto..."
flutter pub run build_runner build --delete-conflicting-outputs

# Entrar a carpeta iOS
cd ios || exit

# Limpiar Pods y caché de CocoaPods
echo "👉 Eliminando Pods y limpiando caché de CocoaPods..."
pod deintegrate
pod cache clean --all

# Reinstalar Pods
echo "👉 Reinstalando Pods..."
pod install

# Volver a la raíz del proyecto
cd ..

# Limpiar DerivedData de Xcode
echo "👉 Borrando DerivedData de Xcode..."
rm -rf ~/Library/Developer/Xcode/DerivedData

echo "✅ Limpieza completa de Flutter + iOS terminada."

echo "👉 Compilando iOS..."
flutter build ios --release

echo "✅ Compilación de iOS terminada."
cd ios

echo "👉 Generando IPA..."

xcodebuild -workspace Runner.xcworkspace \
  -scheme Runner \
  -configuration Release \
  -sdk iphoneos \
  -archivePath build/Runner.xcarchive \
  archive DEVELOPMENT_TEAM={TEAMID} PROFILE_SPECIFIER="{PROFILE}"

xcodebuild -exportArchive \
  -archivePath build/Runner.xcarchive \
  -exportPath build/ipa \
  -exportOptionsPlist ExportOptions.plist

echo "✅ Generación de IPA terminada."

cd ..