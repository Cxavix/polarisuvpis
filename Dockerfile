# Etapa 1: Construcción del frontend y del backend
FROM node:20.5.0 AS builder

# Crear directorios para el frontend y el backend
WORKDIR /app

# Copiar los archivos del frontend
COPY ./FRONT_PIS/package*.json ./FRONT_PIS/
COPY ./FRONT_PIS/ /app/frontend/

# Copiar los archivos del backend
COPY ./back_pis/package*.json ./back_pis/
COPY ./back_pis/ /app/backend/

RUN cd /app/backend && npm install && npm install axios
# Instalar dependencias del frontend
RUN cd /app/frontend && npm install && npm install -g npm@10.4.0 && npm install react-ace ace-builds

# Instalar dependencias del backend


# Exponer el puerto necesario para el servidor (puedes cambiarlo según sea necesario)
EXPOSE 3000

# Iniciar tanto el frontend como el backend al iniciar el contenedor
CMD ["sh", "-c", "cd /app/frontend && npm start & cd /app/backend && npm start"]

