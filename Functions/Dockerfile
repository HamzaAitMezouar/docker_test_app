FROM node:16-alpine

RUN npm install -g nodemon

WORKDIR /test

COPY . .

RUN npm install

EXPOSE 3000

CMD [ "npm","run","dev"]