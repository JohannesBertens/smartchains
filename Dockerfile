FROM node:7-slim as temp

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV=$NODE_ENV DEBUG=express:*

COPY package.json /usr/src/app/
COPY yarn.lock /usr/src/app/
RUN yarn install

COPY . /usr/src/app
RUN yarn build

FROM nginx:1-alpine as final
COPY --from=temp /usr/src/app/build /usr/share/nginx/html