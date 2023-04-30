#!/usr/bin/env python
# coding=utf-8
import pika

credentials = pika.PlainCredentials('rabbit','12345')
connection = pika.BlockingConnection(pika.ConnectionParameters('debian2',5672,'/',credentials))
channel = connection.channel()
channel.queue_declare(queue='hello')


def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)


channel.basic_consume('hello', callback, auto_ack=True)
channel.start_consuming()

