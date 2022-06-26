# Create a simple consumer
from kafka import KafkaConsumer

# To consume latest messages and auto-commit offsets
consumer = KafkaConsumer(
    'test',
    auto_offset_reset='earliest',
    bootstrap_servers=['localhost:9092']
)

for message in consumer:
    print("%s:%d:%d: key=%s value=%s" % (
        message.topic,
        message.partition,
        message.offset, message.key,
        message.value
    ))
