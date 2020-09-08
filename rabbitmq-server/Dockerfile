FROM rabbitmq:3-management
COPY ./rabbitmq-consistent-hash-exchange-3.8.6-rc.2 /opt/rabbitmq/plugins/
RUN rabbitmq-plugins enable rabbitmq_consistent_hash_exchange
