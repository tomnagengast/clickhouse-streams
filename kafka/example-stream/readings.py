from kafka import KafkaProducer
import datetime
import random
import time


def on_send_success(record_metadata):
    print('topic: {}, partition: {}, offset: {}'.format(
        record_metadata.topic,
        record_metadata.partition,
        record_metadata.offset
    ))


def on_send_error(excp):
    log.error('I am an errback', exc_info=excp)
    # handle exception


producer = KafkaProducer(
    bootstrap_servers=['localhost:9092'],
    retries=5
)

# Loop every second
while True:
    # sensor_id = 11
    sensor_id = 38
    current_timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    reading = round(random.uniform(60, 80), 2)

    msg = '"{}","{}","{}"'.format(sensor_id, current_timestamp, reading)
    producer.send('readings', bytes(msg, 'UTF-8')).add_callback(on_send_success).add_errback(on_send_error)
    producer.flush()
    time.sleep(1)
