FROM cypress/included:8.6.0

WORKDIR /app

COPY package.json .

RUN npm i

COPY . .

CMD ["npm", "cypress", "run"]