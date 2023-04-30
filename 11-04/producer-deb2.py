#!/usr/bin/env python
# coding=utf-8
import pika

credentials = pika.PlainCredentials('rabbit','12345')
connection = pika.BlockingConnection(pika.ConnectionParameters('debian2',5672,'/',credentials))
channel = connection.channel()
channel.queue_declare(queue='hello')
channel.basic_publish(exchange='', routing_key='hello', body='Hello Netology!')
print(" [x] Sent 'Hello World!'")
connection.close()
