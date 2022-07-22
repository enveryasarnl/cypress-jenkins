FROM cypress/included

WORKDIR /app

COPY package.json .

RUN npm i

COPY . .

CMD ["npm", "cypress", "run"]