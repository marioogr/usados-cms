FROM node:18 as build
WORKDIR /usr/src/app

COPY package.json  .
COPY yarn.lock .
COPY .env .

ENV NODE_ENV production

RUN yarn install --production --quiet --frozen-lockfile
COPY . .

#needed for files and folder creation by Cloud Run
RUN chmod 777 /usr/src/app/node_modules
RUN chmod 777 /usr/src/app/public/uploads

RUN yarn build

EXPOSE 1337
EXPOSE 5432

#changing user
USER 1000

CMD ["yarn","develop"]