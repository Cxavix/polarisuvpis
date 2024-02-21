# Etapa 1: Construcción del frontend y del backend
FROM node:20.5.0 AS builder

# Crear directorio para la aplicación
WORKDIR /app

# Copiar los archivos del frontend y del backend
COPY ./FRONT_PIS/package*.json ./FRONT_PIS/
COPY ./FRONT_PIS/ /app/frontend/
COPY ./back_pis/package*.json ./back_pis/
COPY ./back_pis/ /app/backend/

# Instalar dependencias del frontend
RUN cd /app/frontend && npm install && npm install -g npm@10.4.0 && npm install react-ace ace-builds

# Instalar dependencias del backend
RUN cd /app/backend && npm install && npm install axios

# Construir el frontend
RUN cd /app/frontend && npm run build

# Exponer el puerto necesario para el servidor
EXPOSE 3000

# Copiar el código de inicio
COPY ./start.sh /app/start.sh

# Dar permisos de ejecución al archivo de inicio
RUN chmod +x /app/start.sh

# Iniciar la aplicación al iniciar el contenedor
CMD ["/app/start.sh"]
