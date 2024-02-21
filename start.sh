#!/bin/bash

# Iniciar el backend en segundo plano
cd /app/backend && npm start &

# Iniciar el frontend
cd /app/frontend && npm start
