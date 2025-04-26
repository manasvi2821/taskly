# Use Node.js official image
FROM node:23-slim 

# Create app directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Expose port
EXPOSE 5000

# Start the app
CMD ["node", "server.js"]
