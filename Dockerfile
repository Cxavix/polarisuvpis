# Etapa 1: Construcción del frontend y del backend
FROM node:20.5.0 AS builder

# Crear directorio para la aplicación
WORKDIR /app

# Copiar los archivos del frontend
COPY ./FRONT_PIS/package*.json ./FRONT_PIS/
COPY ./FRONT_PIS/ /app/frontend/

# Copiar los archivos del backend
COPY ./back_pis/package*.json ./back_pis/
COPY ./back_pis/ /app/backend/

# Instalar dependencias del frontend
RUN cd /app/frontend && npm install && npm install -g npm@10.4.0 && npm install react-ace ace-builds

# Instalar dependencias del backend
RUN cd /app/backend && npm install && npm install axios

# Exponer el puerto necesario para el servidor del backend
EXPOSE 3010

# Exponer el puerto necesario para el servidor del frontend
EXPOSE 3000

# Iniciar el backend al iniciar el contenedor
CMD ["sh", "-c", "cd /app/backend && npm start"]

# Etapa 2: Ejecutar el frontend
FROM node:20.5.0 AS frontend_runner

# Copiar los archivos del frontend
COPY --from=builder /app/frontend /app/frontend

# Exponer el puerto necesario para el servidor del frontend
EXPOSE 3000

# Iniciar el frontend al iniciar el contenedor
CMD ["sh", "-c", "cd /app/frontend && npm start"]

