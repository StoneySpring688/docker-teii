FROM alpine:latest

# Creamos carpeta de salida (aunque luego se sobrescriba por el volumen)
RUN mkdir /output

# Copiamos el script
COPY guardar_fecha.sh /guardar_fecha.sh

# Establecemos el comando principal
CMD ["/guardar_fecha.sh"]
