FROM node:18-alpine
WORKDIR /app
 
# Copy and install backend dependencies
COPY backend/package*.json ./
RUN npm install --omit=dev
 
# Copy backend code
COPY backend/ .
 
# Copy frontend into public folder served by express
COPY frontend/ ./public/
 
EXPOSE 3000
 
CMD ["node", "server.js"]