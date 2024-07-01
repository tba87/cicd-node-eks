########### NODE BUILD  ###############


# Use an official Node.js runtime as a parent image
FROM node:16 as nodebuild

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install app dependencies, including Material-UI 5
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Build the React app
RUN npm run build

# Expose the port that the app will run on (adjust if needed)
# EXPOSE 3000

# Define the command to start the app
# CMD ["npm", "start"]



############  NGINX BUILD ######################

# USING BASE IMAGE: NGINX
FROM nginx:1.23-alpine

# MAKING DEFAULT WORKDIR
WORKDIR /usr/share/nginx/html

# REMOVING OLD index.html
RUN rm -rf ./*

# COPYING all FILES FROM PREVIOUS BUILD
COPY --from=nodebuild /app/build .


#RUNNING THE NGINX AS FOREGROUND
ENTRYPOINT ["nginx", "-g", "daemon off;"]
