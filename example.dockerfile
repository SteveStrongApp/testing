FROM risingstack/alpine:3.4-v6.3.0-3.6.2


# use this build command
#  docker build -f nodesmall.dockerfile -t datalift/dailyshow.datalift .

# use this run command
#  docker run -d -p 4000:3000 -p 4040:8080 datalift/rethink.datalift
#  docker run -d -p 4000:3000 -p 4040:8080 datalift/dailyshow.datalift

#test server
# docker-machine ip

#push to hub
#  docker pull datalift/dailyshow.datalift
#  docker push datalift/dailyshow.datalift

ENV APP=/var/www

# Create app directory
RUN mkdir -p $APP
WORKDIR $APP

# Install app dependencies
COPY package.json $APP
RUN npm install --production

# Bundle app source
COPY . $APP

EXPOSE 3000
CMD [ "npm", "start", "--production", "--noquery" ]
