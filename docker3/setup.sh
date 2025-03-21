#!/bin/bash

set -e  # Salir si hay error
echo "🚀 Iniciando configuración de contenedores..."

# Función para comprobar si una imagen existe
imagen_existe() {
    docker image inspect "$1" > /dev/null 2>&1
}

# Función para comprobar si un contenedor está corriendo
contenedor_corriendo() {
    docker ps --format '{{.Names}}' | grep -q "^$1$"
}

# -------------------------------
# Construir imagen guardar-fecha
# -------------------------------
if ! imagen_existe guardar-fecha; then
    echo "🛠️ Construyendo imagen guardar-fecha..."
    docker build -t guardar-fecha ../docker2
else
    echo "✅ Imagen guardar-fecha ya existe"
fi

# -------------------------------
# Construir imagen servidor-web
# -------------------------------
if ! imagen_existe serverport9000; then
    echo "🛠️ Construyendo imagen serverport9000..."
    docker build -t serverport9000 .
else
    echo "✅ Imagen serverport9000 ya existe"
fi

# -------------------------------
# Crear carpeta data si no existe
# -------------------------------
mkdir -p ./data

# -------------------------------
# Ejecutar contenedor guardar-fecha
# -------------------------------
if ! contenedor_corriendo guardar-fecha; then
    echo "🚀 Lanzando contenedor guardar-fecha..."
    docker run -d --name guardar-fecha -v $(pwd)/data:/output guardar-fecha
else
    echo "✅ Contenedor guardar-fecha ya está en ejecución"
fi

# -------------------------------
# Ejecutar contenedor servidor-web
# -------------------------------
if ! contenedor_corriendo servidor-web; then
    echo "🚀 Lanzando contenedor servidor-web..."
    docker run -d --name servidor-web -p 9000:9000 -v $(pwd)/data:/data serverport9000
else
    echo "✅ Contenedor servidor-web ya está en ejecución"
fi

echo "🌐 Accede al servidor web en: http://localhost:9000/fechashoras.txt"

