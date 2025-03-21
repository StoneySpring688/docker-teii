#!/bin/bash

set -e

# Nombre del proyecto para docker-compose
PROJECT_NAME="proyecto_docker_teii"

echo "🔍 Comprobando si Docker está instalado..."
if ! command -v docker &> /dev/null; then
    echo "⚙️ Docker no encontrado. Instalando..."
    sudo apt update
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
else
    echo "✅ Docker ya está instalado."
fi

echo "🔍 Comprobando si Docker Compose está instalado..."
if ! command -v docker-compose &> /dev/null; then
    echo "⚙️ Docker Compose no encontrado. Instalando..."
    sudo apt install -y docker-compose
else
    echo "✅ Docker Compose ya está instalado."
fi

echo "📦 Creando red y volumen si no existen..."
mkdir -p data

echo "🌐 Preparando el servidor web para mostrar el archivo 'fechashoras.txt' en http://localhost:9000"
echo "📡 Asegúrate de que el contenedor 'guardar-fecha' está escribiendo en './data' correctamente."

echo "🚀 Lanzando docker-compose (Ctrl+C para detener)..."
docker-compose -p "$PROJECT_NAME" up --build

# Esta parte solo se ejecuta si el usuario cancela manualmente con Ctrl+C
echo ""
echo "🛑 Detenido por el usuario. Limpiando..."

echo "🧹 Eliminando contenedores, imágenes y volúmenes del proyecto..."
docker-compose -p "$PROJECT_NAME" down --rmi all --volumes

echo "✅ Todo limpio. Fin del script."
echo "🌐 El servidor ya no está disponible en http://localhost:9000"

