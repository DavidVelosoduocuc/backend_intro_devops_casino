# Stage 1: Install dependencies
FROM node:20-alpine AS builder

WORKDIR /app

COPY package.json ./
RUN npm install

# Stage 2: Runtime image
FROM node:20-alpine

ENV NODE_ENV=production
WORKDIR /app

COPY package.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY . .

EXPOSE 3000

USER node

CMD ["node", "src/server.js"]
