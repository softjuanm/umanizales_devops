# Usar image oficial para construir la aplicación
FROM node:18-alpine AS builder

WORKDIR /app

# Instalar dependencias del proyecto
RUN npm ci --legacy-peer-deps

# Hago el build de la aplicacion
RUN npm run build

# Servir con nginx
FROM nginx:alpine

# Copiar configuración personalizada de nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copiar los archivos construidos desde el builder
COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
