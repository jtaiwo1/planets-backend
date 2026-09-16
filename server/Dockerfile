FROM node:24
WORKDIR /app
COPY package*.json /app
RUN npm install
COPY . /app
ENV PORT=80
ENV DB_USER=postgres
ENV DB_HOST=planets-db
ENV DB_NAME=planets
ENV DB_PASSWORD=docker
ENV DB_PORT=5432
EXPOSE 80
CMD ["node", "index.js"]
