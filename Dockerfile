FROM processmaker/pm4-base:1.0.0

WORKDIR /tmp
RUN wget https://github.com/ProcessMaker/processmaker/archive/refs/tags/v4.1.21.zip
RUN unzip v4.1.21.zip && rm -rf /code/pm4 && mv processmaker-4.1.21 /code/pm4

WORKDIR /code/pm4
RUN composer install
COPY build-files/laravel-echo-server.json .
RUN npm install --unsafe-perm=true && npm run dev

COPY build-files/laravel-echo-server.json .
COPY build-files/init.sh .

CMD bash init.sh && supervisord --nodaemon
