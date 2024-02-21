# Etapa 1: Construcción del frontend
FROM node:20.5.0 AS frontend_builder

# Crear directorio para el frontend
WORKDIR /app/frontend

# Copiar los archivos del frontend
COPY ./FRONT_PIS/package*.json ./FRONT_PIS/
COPY ./FRONT_PIS/ /app/frontend/

# Instalar dependencias del frontend
RUN npm install
RUN npm install -g npm@10.4.0
RUN npm install react-ace ace-builds

# Construir el frontend
RUN npm run build

# Etapa 2: Construcción del backend
FROM node:20.5.0 AS backend_builder

# Crear directorio para el backend
WORKDIR /app/backend

# Copiar los archivos del backend
COPY ./back_pis/package*.json ./back_pis/
COPY ./back_pis/ /app/backend/

# Instalar dependencias del backend
RUN npm install
RUN npm install axios

# Etapa 3: Combinar frontend y backend en un contenedor final
FROM node:20.5.0

# Crear directorio para la aplicación
WORKDIR /app

# Copiar los archivos del frontend y el backend
COPY --from=frontend_builder /app/frontend/build /app/frontend/build
COPY --from=backend_builder /app/backend /app/backend

# Copiar el archivo de inicio del backend
COPY ./start.sh /app/start.sh

# Dar permisos de ejecución al archivo de inicio
RUN chmod +x /app/start.sh

# Exponer los puertos necesarios para el frontend y el backend
EXPOSE 3000
EXPOSE 3010

# CMD predeterminado para ejecutar la aplicación
CMD ["./start.sh"]
