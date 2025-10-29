#!/bin/bash

echo "🧹 Iniciando limpieza total de Flutter + Android..."

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

# Entrar a carpeta Android
cd android || exit

# Limpiar Gradle y caché de Gradle
echo "👉 Eliminando Gradle y limpiando caché de Gradle..."
./gradlew clean

# Reinstalar Gradle
echo "👉 Reinstalando Gradle..."
./gradlew assembleDebug

echo "Generación de Bundle"

flutter build appbundle --release

echo "✅ Generación de Bundle terminada."

