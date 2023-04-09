#!/bin/bash

#Добавить репозиторий RabbitMQ

#По умолчанию пакет RabbitMQ не включен в стандартный репозиторий Debian 11. Поэтому вам нужно будет добавить репозиторий RabbitMQ в вашу систему.
#Сначала установите все необходимые зависимости с помощью следующей команды:
apt-get install gnupg2 curl wget apt-transport-https software-properties-common -y
#После установки всех зависимостей загрузите и установите пакет репозитория Erlang с помощью следующей команды:
wget https://packages.erlang-solutions.com/erlang/debian/pool/esl-erlang_23.1.5-1~debian~stretch_amd64.deb
dpkg -i esl-erlang_23.1.5-1~debian~stretch_amd64.deb
#Вы получите некоторые ошибки зависимости. Вы можете исправить их, выполнив следующую команду:
apt-get install -yf
rm /etc/apt/sources.list.d/rabbitmq.list
rm /etc/apt/sources.list.d/rabbitmq.list.save
#Затем обновите репозиторий Erlang и установите пакет Erlang с помощью следующей команды:
apt-get update -y
apt-get install -y erlang erlang-nox
#Затем добавьте репозиторий RabbitMQ с помощью следующей команды:
add-apt-repository 'deb http://www.rabbitmq.com/debian/ testing main'
wget https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add -
#После добавления репозитория обновите репозиторий с помощью следующей команды:
apt-get update -y
#Как только вы закончите, вы можете перейти к следующему шагу.

#Установите сервер RabbitMQ

#Теперь вы можете установить сервер RabbitMQ, выполнив следующую команду:
apt-get install rabbitmq-server -y
#После завершения установки запустите службу RabbitMQ и включите ее запуск при перезагрузке системы:
systemctl start rabbitmq-server
systemctl enable rabbitmq-server
rabbitmq-plugins enable rabbitmq_management
systemctl status rabbitmq-server

