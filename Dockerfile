FROM ubuntu

RUN apt-get update && apt-get install -y nodejs npm

COPY index.js index.js
COPY package.json package.json
COPY package-lock.json package-lock.json

RUN npm install

ENTRYPOINT [ "nodejs", "index.js" ]