import logging

from confluent_kafka.admin import AdminClient

logger = logging.getLogger(__name__)

def topic_exists(topic):
    """Checks if the given topic exists in Kafka"""
    client = AdminClient({"bootstrap.servers": "PLAINTEXT://localhost:9092"})
    topic_metadata = client.list_topics(timeout=5)
    is_existed = topic in set(t.topic for t in iter(topic_metadata.topics.values()))
    logger.info(f"Topic {topic} is {is_existed}")

    return is_existed

