FROM node:latest
WORKDIR /usr/local/app
COPY . /usr/local/app/
RUN npm install -g nodemon && npm ci && npm cache clean --force && mv /usr/local/app/node_modules /node_modules
ENV PORT=4000
CMD [ "node","server.js" ]
EXPOSE $PORT