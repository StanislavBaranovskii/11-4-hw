# Домашнее задание к занятию 11.4. «`Очереди RabbitMQ`» - `Барановский Станислав`

### Инструкция по выполнению домашнего задания

1. Сделайте fork [репозитория c шаблоном решения](https://github.com/netology-code/sys-pattern-homework) к себе в Github и переименуйте его по названию или номеру занятия, например, https://github.com/имя-вашего-репозитория/gitlab-hw или https://github.com/имя-вашего-репозитория/8-03-hw).
2. Выполните клонирование этого репозитория к себе на ПК с помощью команды `git clone`.
3. Выполните домашнее задание и заполните у себя локально этот файл README.md:
   - впишите вверху название занятия и ваши фамилию и имя;
   - в каждом задании добавьте решение в требуемом виде: текст/код/скриншоты/ссылка;
   - для корректного добавления скриншотов воспользуйтесь инструкцией [«Как вставить скриншот в шаблон с решением»](https://github.com/netology-code/sys-pattern-homework/blob/main/screen-instruction.md);
   - при оформлении используйте возможности языка разметки md. Коротко об этом можно посмотреть в [инструкции по MarkDown](https://github.com/netology-code/sys-pattern-homework/blob/main/md-instruction.md).
4. После завершения работы над домашним заданием сделайте коммит (`git commit -m "comment"`) и отправьте его на Github (`git push origin`).
5. Для проверки домашнего задания преподавателем в личном кабинете прикрепите и отправьте ссылку на решение в виде md-файла в вашем Github.
6. Любые вопросы задавайте в чате учебной группы и/или в разделе «Вопросы по заданию» в личном кабинете.

Желаем успехов в выполнении домашнего задания.

---

## Задание 1. Установка RabbitMQ

Используя Vagrant или VirtualBox, создайте виртуальную машину и установите RabbitMQ.
Добавьте management plug-in и зайдите в веб-интерфейс.

*Итогом выполнения домашнего задания будет приложенный скриншот веб-интерфейса RabbitMQ.*

### Установка и запуск RabbitMQ

```bash
sudo apt install -y curl gnupg apt-transport-https -y
curl -1sLf "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xf77f1eda57ebb1cc" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg > /dev/null
curl -1sLf "https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/io.packagecloud.rabbitmq.gpg > /dev/null

sudo nano /etc/apt/sources.list.d/rabbitmq.list 
```
Содежимое файла rabbitmq.list
```shell script
## Provides modern Erlang/OTP releases
deb [signed-by=/usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg] http://ppa.launchpad.net/rabbitmq/rabbitmq-erlang/ubuntu jammy main
deb-src [signed-by=/usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg] http://ppa.launchpad.net/rabbitmq/rabbitmq-erlang/ubuntu jammy main
## Provides RabbitMQ
deb [signed-by=/usr/share/keyrings/io.packagecloud.rabbitmq.gpg] https://packagecloud.io/rabbitmq/rabbitmq-server/ubuntu/ jammy main
deb-src [signed-by=/usr/share/keyrings/io.packagecloud.rabbitmq.gpg] https://packagecloud.io/rabbitmq/rabbitmq-server/ubuntu/ jammy main
```

```bash
sudo apt update
sudo apt install -y erlang-base \
erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
erlang-runtime-tools erlang-snmp erlang-ssl \
erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl
sudo apt install -y rabbitmq-server --fix-missing

sudo systemctl status rabbitmq-server
sudo systemctl enable rabbitmq-server

sudo rabbitmq-plugins enable rabbitmq_management

http://localhost:15672  #guest:guest ИЛИ, для доступа по внешнему IP создаем пользователя admin :
sudo rabbitmqctl add_user admin 12345
sudo rabbitmqctl set_user_tags admin administrator
sudo rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"

```
### Скриншот RabbitMQ
![Скриншот RabbitMQ](https://github.com/StanislavBaranovskii/11-4-hw/blob/main/img/11-4-1.png "Скриншот RabbitMQ")

---

## Задание 2. Отправка и получение сообщений

Используя приложенные скрипты, проведите тестовую отправку и получение сообщения.
Для отправки сообщений необходимо запустить скрипт producer.py.

Для работы скриптов вам необходимо установить Python версии 3 и библиотеку Pika.
Также в скриптах нужно указать IP-адрес машины, на которой запущен RabbitMQ, заменив localhost на нужный IP.

```shell script
$ pip install pika
```

Зайдите в веб-интерфейс, найдите очередь под названием hello и сделайте скриншот.
После чего запустите второй скрипт consumer.py и сделайте скриншот результата выполнения скрипта

*В качестве решения домашнего задания приложите оба скриншота, сделанных на этапе выполнения.*

Для закрепления материала можете попробовать модифицировать скрипты, чтобы поменять название очереди и отправляемое сообщение.

### Выполнение тестовой отправки и получения сообщения

```bash
# В GUI создал очередь hello
sudo rabbitmqctl list_queues
sudo pip install pika # Для работы с очередями
# Для ubuntu: команда rabbitmqadmin не найдена, но должна была установится с пакетом rabbitmq-server 
# Для ubuntu: Устанавливаю самостоятельно:
#wget https://raw.githubusercontent.com/rabbitmq/rabbitmq-management/v3.7.8/bin/rabbitmqadmin
wget https://raw.githubusercontent.com/rabbitmq/rabbitmq-management/v3.7.15/bin/rabbitmqadmin
sudo chmod +x rabbitmqadmin
python3 -V
python -V
sed -i 's|#!/usr/bin/env python|#!/usr/bin/env python3|' rabbitmqadmin  #правим в заголовоке скрипта на python3
sudo cp rabbitmqadmin /bin/
rabbitmqadmin --version

rabbitmqadmin -f tsv -q list queues
rabbitmqadmin get queue='hello'
rabbitmqadmin delete queue name='hello'

python3 producer.py

# Редактирование скрипта consumer.py
# Вместо  channel.basic_consume(callback, queue='hello', no_ack=True)
# Заменил на  channel.basic_consume('hello', callback, auto_ack=True)

python3 consumer.py

```
### Скриншот очереди hello (producer.py)
![Скриншот очереди hello](https://github.com/StanislavBaranovskii/11-4-hw/blob/main/img/11-4-2-1.png "Скриншот очереди")

### Скриншот очереди hello (consumer.py)
![Скриншот очереди](https://github.com/StanislavBaranovskii/11-4-hw/blob/main/img/11-4-2-2.png "Скриншот очереди")

---

## Задание 3. Подготовка HA кластера

Используя Vagrant или VirtualBox, создайте вторую виртуальную машину и установите RabbitMQ.
Добавьте в файл hosts название и IP-адрес каждой машины, чтобы машины могли видеть друг друга по имени.

Пример содержимого hosts файла:
```shell script
$ cat /etc/hosts
192.168.0.10 rmq01
192.168.0.11 rmq02
```
После этого ваши машины могут пинговаться по имени.

Затем объедините две машины в кластер и создайте политику ha-all на все очереди.

*В качестве решения домашнего задания приложите скриншоты из веб-интерфейса с информацией о доступных нодах в кластере и включённой политикой.*
### Скриншот доступных нод
![Скриншот доступных нод](https://github.com/StanislavBaranovskii/11-4-hw/blob/main/img/11-4-3-1.png "Скриншот доступных нод")
### Скриншот включенной политики
![Скриншот включенной политики](https://github.com/StanislavBaranovskii/11-4-hw/blob/main/img/11-4-3-2.png "Скриншот включенной политики")

Также приложите вывод команды с двух нод:

```shell script
$ rabbitmqctl cluster_status
```
### Скриншот вывод команды
![Скриншот вывод команды](https://github.com/StanislavBaranovskii/11-4-hw/blob/main/img/11-4-3-3.png "Скриншот вывод команды")

Для закрепления материала снова запустите скрипт producer.py и приложите скриншот выполнения команды на каждой из нод:

```shell script
$ rabbitmqadmin get queue='hello'
```
```bash
rabbitmqadmin get queue='hello' -H debian1 -P 15672 -u rabbit -p 12345
rabbitmqadmin get queue='hello' -H debian2 -P 15672 -u rabbit -p 12345
```
### Скриншот выполнения команды на нодах debian1 и debian2
![Скриншот выполнения команды](https://github.com/StanislavBaranovskii/11-4-hw/blob/main/img/11-4-3-4.png "Скриншот выполнения команды")

После чего попробуйте отключить одну из нод, желательно ту, к которой подключались из скрипта, затем поправьте параметры подключения в скрипте consumer.py на вторую ноду и запустите его.

### Скриншот выполнения команды на ноде debian1 после отключения ноды debian2
![Скриншот выполнения команды](https://github.com/StanislavBaranovskii/11-4-hw/blob/main/img/11-4-3-5.png "Скриншот выполнения команды")

*Приложите скриншот результата работы второго скрипта.*


```bash
sudo apt install ufw
sudo ufw enable
sudo ufw allow 15672/tcp
sudo ufw allow 5672/tcp
sudo ufw allow 4369/tcp
sudo ufw allow 25672/tcp
sudo ufw reload
sudo ufw status

#Скопировать файл /var/lib/rabbitmq/.erlang.cookie с ноды rabbit@debian1 на ноду rabbit@debian2
sudo systemctl restart rabbitmq-server #На второй ноде rabbit@debian2
sudo rabbitmqctl stop_app #На второй ноде rabbit@debian2
sudo rabbitmqctl join_cluster rabbit@debian1 #На второй ноде rabbit@debian2
sudo rabbitmqctl start_app #На второй ноде rabbit@debian2

sudo rabbitmqctl cluster_status

sudo rabbitmqctl delete_user guest
sudo rabbitmqctl list_users

#политика позволяет всем очередям быть зеркалированными на всех узлах кластера RabbitMQ:
sudo rabbitmqctl set_policy ha-all ".*" '{"ha-mode": "all"}'
sudo rabbitmqctl list_policies
```
Редактируем скрипты [producer-deb1.py](https://github.com/StanislavBaranovskii/11-4-hw/blob/main/11-04/producer-deb1.py) и [consumer-deb1.py](https://github.com/StanislavBaranovskii/11-4-hw/blob/main/11-04/consumer-deb1.py) для работы с очередями в кластере на нодах debian1 и debian2:
```shell script
credentials = pika.PlainCredentials('rabbit','12345')
connection = pika.BlockingConnection(pika.ConnectionParameters('debian1',5672,'/',credentials))
```
Редактируем скрипты [producer-deb2.py](https://github.com/StanislavBaranovskii/11-4-hw/blob/main/11-04/producer-deb2.py) и [consumer-deb2.py](https://github.com/StanislavBaranovskii/11-4-hw/blob/main/11-04/consumer-deb2.py) для работы с очередями в кластере на нодах debian1 и debian2:
```shell script
credentials = pika.PlainCredentials('rabbit','12345')
connection = pika.BlockingConnection(pika.ConnectionParameters('debian2',5672,'/',credentials))
```

---

## Задание 4*. Ansible playbook

Напишите плейбук, который будет производить установку RabbitMQ на любое количество нод и объединять их в кластер.
При этом будет автоматически создавать политику ha-all.

*Готовый плейбук разместите в своём репозитории.*

---
