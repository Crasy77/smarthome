#!/bin/bash

#echo $1 $2 $3
user_id=$1
TEXT=$2
COMM=$3
message_id=$4

DATE=$(date +"%Y-%m-%d_%H-%M-%S")

#Telegram message bot
# me 660882040
token=$(cat /home/pi/telegram_my_token)

#TEXT="Test test"
URL="https://api.telegram.org/bot$token"
c_msg_send=$URL'/sendMessage'
#c_msg_but='"reply_markup": {"inline_keyboard": [[{"text": "Текст","url": "https:\/\/example.com\/ya3bal\/nus\/sus"}]]}'

#c_msg_but='{"keyboard":[[{"text":"/start"}],[{"text":"/lamponn"},{"text":"/lampoff"}],[{"text":"/set 106 1"},{"text":"/set 106 0"}],[{"text":"/set 107 1"},{"text":"/set 107 0"}],["Простая кнопка",{"text":"Расход"}]]}'

#c_msg_but='{"keyboard":[[{"text":"/start"}],[{"text":"/set 103 1"},{"text":"/set 106 0"}],[{"text":"/set 107 1"},{"text":"/set 107 0"}],["Простая кнопка",{"text":"Расход"}]]} }'
#c_msg_but='{"keyboard":[ [{"text":"/start"}] ]}'

c_msg_but=''
c_msg_but_main='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"keyboard":['\
'[{"text":"/stop"}]'\
',["Лампы \uD83D\uDCA1","Розетки","Реле"]'\
',["Датчики","Плеер"]'\
',["Камера39 \ud83d\uDCF7","Камера37 \ud83d\uDCF7","Камера33 \ud83d\uDCF7","Камера34 \ud83d\uDCF7"]'\
',["\ud83d\udcf4","\ud83d\udcf5","\ud83d\udcf6","\ud83d\ude08","\ud83d\ude09","\ud83d\ude10","\ud83d\ude11"]'\
',["Охрана \uD83D\uDEA8","Сервис \ud83d\udcf4","Кто дома \ud83d\udcf3"]'\
']} }'

if [ "$COMM" == '/start' ] ;then
/home/pi/telegram_sendinfo.py $user_id 2 "Охрана"

#тест вариант с автозагрузкой
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"keyboard":['\
'[{"text":"/stop"}]'
  for ((i=1; i < 5; i++))
  do
c_msg_but=$c_msg_but\
',["Выключатель'$i' \uD83D\uDCA1","Розетки","Реле"]'
  done
c_msg_but=$c_msg_but\
',["Охрана \uD83D\uDEA8","Сервис \ud83d\udcf4","Кто дома \ud83d\udcf3"]'\
']} }'

#разные иконки эмоджи emoji
#https://symbl.cc/en/1F321/
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"keyboard":['\
'[{"text":"/start"},{"text":"/stop"}]'\
',["Лампы \uD83D\uDCA1","Розетки","Реле"]'\
',["Температура \uD83C\uDF21","Датчики","Плеер","Термостаты"]'\
',["Лампа балкон","Лампа икея","Лампа спальня"]'\
',["Камера39 \ud83d\uDCF7","Камера51 \ud83d\uDCF7","Камера41 \ud83d\uDCF7","Камера33 \ud83d\uDCF7","Камера34 \ud83d\uDCF7"]'\
',["\ud83d\udcf4","\ud83d\udcf5","\ud83d\udcf6","\ud83d\ude08","\ud83d\ude09","\ud83d\ude10","\ud83d\ude11"]'\
',["Охрана \uD83D\uDEA8","Сервис \ud83d\udcf4","Кто дома \ud83d\udcf3"]'\
']} }'

#',["Тест","Тест2","Тест3","Тест4","Тест5","Тест6","Тест7","Тест8","Тест9","Тест0"]'\
##',["Тест","Тест2","Тест3","Тест4","Тест5","Тест6","Тест7","Тест8","Тест9","Тест0"]'

#660882040
#/home/pi/telegram_sendinfo.py 660882040 11109 "Леха"
elif [[ "$COMM" == "Кто дома"* ]] ;then
/home/pi/telegram_sendinfo.sh $user_id 11109 "Леха"
/home/pi/telegram_sendinfo.sh $user_id 11106 "Гриша"
/home/pi/telegram_sendinfo.sh $user_id 11100 "Саша"
/home/pi/telegram_sendinfo.sh $user_id 11103 "Оля"
/home/pi/telegram_sendinfo.sh $user_id 11116 "J5"
#/home/pi/telegram_sendinfo.py $user_id 11116 "J5"

elif [ "$COMM" == "Охрана" ]
then
/home/pi/telegram_sendinfo.py $user_id 2 "Охрана"
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"keyboard":['\
'[{"text":"/start"}]'\
',["Поставить","Снять"]'\
',["Датчики"]'\
',["Кто дома"]'\
',["Запись","Камера"]'\
']} }'
elif [ "$COMM" == "Поставить" ]
then
/home/pi/mysql_sensor.py 2 1
/home/pi/telegram_sendevent.sh $user_id "Поставлено на охрану"

elif [ "$COMM" == "Снять" ]
then
/home/pi/mysql_sensor.py 2 0
/home/pi/telegram_sendevent.sh $user_id "Снято с охраны"

elif [ "$COMM" == 'Датчики' ]
then
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"keyboard":['\
'["/start"]'\
',["Кухня"]'\
',["Спальня"]'\
',["Детская"]'\
',["Ванная"]'\
',["Балкон"]'\
',["Raspberry"]'\
']} }'
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"inline_keyboard":['\
'[{"text":"Датчики","callback_data":"Датчики"}]'\
',[{"text":"Кухня","callback_data":"Датчики Кухня"},{"text":"Спальня","callback_data":"Датчики Спальня"}]'\
',[{"text":"Детская","callback_data":"Датчики Детская"},{"text":"Ванная","callback_data":"Датчики Ванная"}]'\
',[{"text":"Балкон","callback_data":"Датчики Балкон"},{"text":"Балкон","callback_data":"Датчики Балкон"}]'\
',[{"text":"Raspberry","callback_data":"Датчики Raspberry"},{"text":"OrangePi3","callback_data":"Датчики OrangePi3"}]'\
']} }'


elif [ "$COMM" == 'Датчики Кухня' ] ;then
#/home/pi/telegram_sendinfo.py $user_id 31 "Температура"
#/home/pi/telegram_sendinfo.py $user_id 32 "Влажность"
/home/pi/telegram_sendmessage.sh $user_id "Температура: $(/home/pi/mysql_info.sh 31 1)°\nВлажность: $(/home/pi/mysql_info.sh 32 0)%"
elif [ "$COMM" == 'Датчики Спальня' ] ;then
#/home/pi/telegram_sendinfo.py $user_id 41 "Температура"
#/home/pi/telegram_sendinfo.py $user_id 42 "Влажность"
/home/pi/telegram_sendmessage.sh $user_id "Температура: $(/home/pi/mysql_info.sh 41 1)°\nВлажность: $(/home/pi/mysql_info.sh 42 0)%"
elif [ "$COMM" == 'Датчики Детская' ] ;then
#/home/pi/telegram_sendinfo.py $user_id 81 "Температура"
#/home/pi/telegram_sendinfo.py $user_id 82 "Влажность"
/home/pi/telegram_sendmessage.sh $user_id "Температура: $(/home/pi/mysql_info.sh 91 1)°\nВлажность: $(/home/pi/mysql_info.sh 92 0)%"
elif [ "$COMM" == 'Датчики Ванная' ] ;then
#/home/pi/telegram_sendinfo.py $user_id 81 "Температура"
#/home/pi/telegram_sendinfo.py $user_id 82 "Влажность"
/home/pi/telegram_sendmessage.sh $user_id "Температура: $(/home/pi/mysql_info.sh 81 1)°\nВлажность: $(/home/pi/mysql_info.sh 82 0)%"
elif [ "$COMM" == 'Датчики Балкон' ] ;then
#/home/pi/telegram_sendinfo.py $user_id 71 "Температура"
#/home/pi/telegram_sendinfo.py $user_id 72 "Влажность"
#/home/pi/telegram_sendinfo.py $user_id 74 "Яркость"
/home/pi/telegram_sendmessage.sh $user_id "Температура: $(/home/pi/mysql_info.sh 71 1)°\nВлажность: $(/home/pi/mysql_info.sh 72 0)% \nЯркость: $(/home/pi/mysql_info.sh 74 0)"
elif [ "$COMM" == 'Датчики Raspberry' ] ;then
#/home/pi/telegram_sendinfo.py $user_id 121 "Температура"
#/home/pi/telegram_sendinfo.py $user_id 122 "Свободно RAM"
#/home/pi/telegram_sendinfo.py $user_id 123 "Свободно HDD"
/home/pi/telegram_sendmessage.sh $user_id "Raspberry:\nТемпература: $(/home/pi/mysql_info.sh 222121)°\nСвободно RAM: $(/home/pi/mysql_info.sh 222122)% \nСвободно HDD: $(/home/pi/mysql_info.sh 222123)%"
elif [ "$COMM" == 'Датчики OrangePi3' ] ;then
/home/pi/telegram_sendmessage.sh $user_id "OrangePi3:\nТемпература: $(/home/pi/mysql_info_avg.sh 554121)°\nСвободно RAM: $(/home/pi/mysql_info_avg.sh 554122)% \nСвободно HDD: $(/home/pi/mysql_info_avg.sh 554123)%"



#elif [[ "$COMM" == 'Сервис'* ]] ;then
elif [[ "$COMM" == 'Сервис '* ]] ;then
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"keyboard":['\
'["/start"]'\
',["Server restart"]'\
',["Openhab restart"]'\
',["Mount restart"]'\
',["Raspberry reboot"]'\
']} }'
#echo "$COMM" >> /home/pi/1.txt
elif [ "$COMM" == 'Server restart' ] ;then
    /home/pi/telegram_sendmessage.sh $user_id "Server перезапуск..."
#    sudo service runscript restart
    ch=$(sleep 5 ; service runscript restart) &    
c_msg_but=$c_msg_but_main
elif [ "$COMM" == 'Openhab restart' ] ;then
    /home/pi/telegram_sendmessage.sh $user_id "Openhab перезапуск..."
    sudo service openhab restart &
c_msg_but=$c_msg_but_main
elif [ "$COMM" == 'Mount restart' ] ;then
    /home/pi/telegram_sendmessage.sh $user_id "Mount перезапуск..."
    ch=$(sudo mount -t cifs //192.168.0.109/pi /mnt/crasyvivo -o _netdev,username=crasy,password=123,iocharset=utf8,file_mode=0777,dir_mode=0777) &
c_msg_but=$c_msg_but_main
elif [ "$COMM" == 'Raspberry reboot' ] ;then
    /home/pi/telegram_sendmessage.sh $user_id "Raspberry перезапуск..."
    ch=$(sleep 5 ; sudo reboot) &
c_msg_but=$c_msg_but_main


elif [ "$COMM" == 'Лампа балкон' ] ;then
#    c_msg_but='{"chat_id":'$user_id',"message_id":'$message_id'}'
#    c_msg_send=$URL'/deleteMessage'
#    curl -d "$c_msg_but" -H "Content-Type: application/json" -X POST $c_msg_send --max-time 5 --connect-timeout 5 &
#tail=$c_msg_but
#tail=${tail//\"/\\\"} #заменяю кавычки для передачи в телеграм
#/home/pi/telegram_sendevent_me.sh "test $tail"
/home/pi/telegram_my_delete.sh "$user_id" "$message_id" &

#c_msg_send=$URL'/sendMessage'
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"inline_keyboard":['\
'[{"text":"Лампа балкон","callback_data":"Лампа балкон"}]'\
',[{"text":"Лампа: '$(/home/pi/mysql_info.sh 107110 0)'","callback_data":"Лампа балкон переключить"},{"text":"Включить","callback_data":"Лампа балкон включить"},{"text":"Выключить","callback_data":"Лампа балкон выключить"}]'\
',[{"text":"Огонь","callback_data":"Лампа балкон Огонь"}]'\
',[{"text":"Люстра: '$(/home/pi/mysql_info.sh 407311 0)'","callback_data":"Люстра балкон переключить"},{"text":"Включить","callback_data":"Люстра балкон включить"},{"text":"Выключить","callback_data":"Люстра балкон выключить"}]'\
',[{"text":"Закат","callback_data":"Люстра балкон Закат"},{"text":"Ярко","callback_data":"Люстра балкон Ярко"}]'\
']} }'
elif [ "$COMM" == 'Лампа балкон переключить' ] ;then
    ch=$(/home/pi/rasp_switch.sh 107110 2) &
elif [ "$COMM" == 'Лампа балкон включить' ] ;then
    ch=$(/home/pi/mqtt_local_pub_new.sh  LedLamp/LedLamp_0049ACD2/cmnd P_ON) &
elif [ "$COMM" == 'Лампа балкон выключить' ] ;then
    ch=$(/home/pi/mqtt_local_pub_new.sh  LedLamp/LedLamp_0049ACD2/cmnd P_OFF) &
elif [ "$COMM" == 'Лампа балкон Огонь' ] ;then
    ch=$(/home/pi/mqtt_local_pub_new.sh  LedLamp/LedLamp_0049ACD2/cmnd EFF1) &

elif [ "$COMM" == 'Люстра балкон переключить' ] ;then
    ch=$(/home/pi/rasp_switch.sh 407311 -1) &
elif [ "$COMM" == 'Люстра балкон включить' ] ;then
    ch=$(/home/pi/rasp_switch.sh 407311 1) &
elif [ "$COMM" == 'Люстра балкон выключить' ] ;then
    ch=$(/home/pi/rasp_switch.sh 407311 0) &
elif [ "$COMM" == 'Люстра балкон Закат' ] ;then
    ch=$(/home/pi/yeelight_my.sh brightness 50) 
    ch=$(home/pi/yeelight_my.sh ct_on 1700) &
elif [ "$COMM" == 'Люстра балкон Ярко' ] ;then
    ch=$(home/pi/yeelight_my.sh ct_on 6500) 
    ch=$(/home/pi/yeelight_my.sh brightness 100) &


elif [ "$COMM" == 'Закрыть' ] ;then
/home/pi/telegram_my_delete.sh "$user_id" "$message_id" &


elif [ "$COMM" == 'Плеер' ] ;then
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"keyboard":['\
'["/start"]'\
',["Play","Pause"]'\
',["Playlist","Chillout","Chillhouse"]'\
',["Плеер спальня","Плеер комната","Плеер балкон"]'\
',["Prev","Next"]'\
']} }'

/home/pi/telegram_my_delete.sh "$user_id" "$message_id" &

c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"inline_keyboard":['\
'[{"text":"Плеер","callback_data":"Плеер"}]'\
',[{"text":"Play","callback_data":"Плеер Play"},{"text":"Pause","callback_data":"Плеер Pause"}]'\
',[{"text":"Playlist","callback_data":"Playlist"},{"text":"Chillout","callback_data":"Chillout"},{"text":"Chillhouse","callback_data":"Chillhouse"}]'\
',[{"text":"Плеер спальня","callback_data":"Плеер спальня"},{"text":"Плеер комната","callback_data":"Плеер комната"},{"text":"Плеер балкон","callback_data":"Плеер балкон"}]'\
',[{"text":"Prev","callback_data":"Плеер Prev"},{"text":"Info","callback_data":"Плеер Info"},{"text":"Next","callback_data":"Плеер Next"}]'\
',[{"text":"Тише","callback_data":"Плеер тише"},{"text":"vol 60%","callback_data":"Плеер Громкость 60%"},{"text":"Громче","callback_data":"Плеер громче"}]'\
']} }'
elif [ "$COMM" == 'Плеер тише' ] ;then
    ch=$(/home/pi/rasp_player_yandex.sh volumedown -10) &
elif [ "$COMM" == 'Плеер громче' ] ;then
    ch=$(/home/pi/rasp_player_yandex.sh volumeup +10) &
elif [ "$COMM" == 'Плеер Громкость 60%' ] ;then
    ch=$(/home/pi/rasp_player_yandex.sh volume 60) &
    
elif [ "$COMM" == 'Playlist' ] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Плеер Playlist..."
    ch=$(/home/pi/rasp_player_yandex.sh channel0) &
#c_msg_but=$c_msg_but_main
elif [ "$COMM" == 'Chillout' ] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Плеер Chillout..."
    ch=$(/home/pi/rasp_player_yandex.sh channel1) &
#c_msg_but=$c_msg_but_main
elif [ "$COMM" == 'Chillhouse' ] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Плеер Chillhouse..."
    ch=$(/home/pi/rasp_player_yandex.sh channel2) &
#c_msg_but=$c_msg_but_main
elif [ "$COMM" == 'Плеер спальня' ] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Плеер спальня..."
    ch=$(/home/pi/rasp_player_yandex.sh 18s) &
#c_msg_but=$c_msg_but_main
elif [ "$COMM" == 'Плеер комната' ] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Плеер комната..."
    ch=$(/home/pi/rasp_player_yandex.sh 12s) &
#c_msg_but=$c_msg_but_main
elif [ "$COMM" == 'Плеер балкон' ] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Плеер балкон..."
    ch=$(/home/pi/rasp_player_yandex.sh 14s) &
#c_msg_but=$c_msg_but_main
elif [ "$COMM" == 'Плеер Play' ] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Play..."
    ch=$(/home/pi/rasp_player_yandex.sh 18s) &
#c_msg_but=$c_msg_but_main
elif [ "$COMM" == 'Плеер Pause' ] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Pause..."
    ch=$(/home/pi/rasp_player_yandex.sh 10s) &
#c_msg_but=$c_msg_but_main
elif [ "$COMM" == 'Плеер Info' ] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Pause..."
    ch=$(/home/pi/rasp_player_yandex.sh info) &
#c_msg_but=$c_msg_but_main


elif [ "$COMM" == 'Термостаты' ] ;then
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"keyboard":['\
'["/start","Термостаты"]'\
',["Термостат Балкон","Термостат Спальня","Термостат Кухня"]'\
',["Балкон","Мощность: '$(/home/pi/mysql_info.sh 107513 0)'%", "Температура: '$(/home/pi/mysql_info.sh 407171 1)'°"]'\
',["Балкон 0%","Балкон 10%","Балкон 11%", "Балкон 51%", "Балкон 100%"]'\
']} }'

/home/pi/telegram_my_delete.sh "$user_id" "$message_id" &

TEXT='Целевая: '$(/home/pi/mysql_info.sh 107517 1)'°, Мощность: '$(/home/pi/mysql_info.sh 107513 0)'%'
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"inline_keyboard":['\
'[{"text":"Термостат Балкон","callback_data":"Термостаты"}]'\
',[{"text":"Мощ: '$(/home/pi/mysql_info.sh 107513 0)'%","callback_data":"ok"},{"text":"Дверь: '$(/home/pi/mysql_info.sh 407006 0)'","callback_data":"ok"},{"text":"Терм: '$(/home/pi/mysql_info.sh 407006 0)'","callback_data":"ok"},{"text":"Роз: '$(/home/pi/mysql_info.sh 634411 0)'","callback_data":"ok"}]'\
',[{"text":"Улица: '$(/home/pi/mysql_info.sh 7 1)'°","callback_data":"ok"},{"text":"Внеш: '$(/home/pi/mysql_info.sh 407171 1)'°","callback_data":"ok"},{"text":"Темп: '$(/home/pi/mysql_info.sh 107514 1)'°","callback_data":"ok"},{"text":"Верх: '$(/home/pi/mysql_info.sh 400281 1)'°","callback_data":"ok"}]'\
',[{"text":"Включить","callback_data":"Термостат Балкон вкл"},{"text":"Термостат: '$(/home/pi/mysql_info.sh 107516 0)'","callback_data":"Отправить"},{"text":"Выключить","callback_data":"Термостат Балкон выкл"}]'\
',[{"text":"Вент: '$(/home/pi/mysql_info.sh 193001 0)'","callback_data":"Вентилятор Балкон переключить"},{"text":"+4°","callback_data":"Термостат целевая 4"},{"text":"+25°","callback_data":"Термостат целевая 25"},{"text":"+26°","callback_data":"Термостат целевая 26"},{"text":"+27°","callback_data":"Термостат целевая 27"}]'\
',[{"text":"0%","callback_data":"Балкон 0%"},{"text":"11%","callback_data":"Балкон 11%"},{"text":"20%","callback_data":"Балкон 20%"},{"text":"33%","callback_data":"Балкон 33%"},{"text":"50%","callback_data":"Балкон 50%"},{"text":"66%","callback_data":"Балкон 66%"},{"text":"100%","callback_data":"Балкон 100%"}]'\
']} }'


elif [ "$COMM" == 'Вентилятор Балкон переключить' ] ;then
    ch=$(/home/pi/rasp_switch.sh 193001 2) &

elif [ "$COMM" == 'Термостат Балкон вкл' ] ;then
    ch=$(/home/pi/mqtt_local_pub_new.sh arduino/esp8266_E0B2A2/ssrda/settermo 1) &
elif [ "$COMM" == 'Термостат Балкон выкл' ] ;then
    ch=$(/home/pi/mqtt_local_pub_new.sh arduino/esp8266_E0B2A2/ssrda/settermo 0) &
    ch=$(/home/pi/mqtt_local_pub_new.sh arduino/esp8266_E0B2A2/ssrda/setpercent 0) &

elif [ "$COMM" == 'Термостат целевая 4' ] ;then
    ch=$(/home/pi/mqtt_local_pub_new.sh arduino/esp8266_E0B2A2/ssrda/settarget 4) &
elif [ "$COMM" == 'Термостат целевая 25' ] ;then
    ch=$(/home/pi/mqtt_local_pub_new.sh arduino/esp8266_E0B2A2/ssrda/settarget 25) &
elif [ "$COMM" == 'Термостат целевая 26' ] ;then
    ch=$(/home/pi/mqtt_local_pub_new.sh arduino/esp8266_E0B2A2/ssrda/settarget 26) &
elif [ "$COMM" == 'Термостат целевая 27' ] ;then
    ch=$(/home/pi/mqtt_local_pub_new.sh arduino/esp8266_E0B2A2/ssrda/settarget 27) &

elif [ "$COMM" == 'Балкон 0%' ] ;then
    ch=$(/home/pi/mqtt_local_pub_new.sh arduino/esp8266_E0B2A2/ssrda/setpercent 0) &
elif [ "$COMM" == 'Балкон 11%' ] ;then
    ch=$(/home/pi/mqtt_local_pub_new.sh arduino/esp8266_E0B2A2/ssrda/setpercent 11) &
elif [ "$COMM" == 'Балкон 20%' ] ;then
    ch=$(/home/pi/mqtt_local_pub_new.sh arduino/esp8266_E0B2A2/ssrda/setpercent 20) &
elif [ "$COMM" == 'Балкон 33%' ] ;then
    ch=$(/home/pi/mqtt_local_pub_new.sh arduino/esp8266_E0B2A2/ssrda/setpercent 33) &
elif [ "$COMM" == 'Балкон 50%' ] ;then
    ch=$(/home/pi/mqtt_local_pub_new.sh arduino/esp8266_E0B2A2/ssrda/setpercent 50) &
elif [ "$COMM" == 'Балкон 66%' ] ;then
    ch=$(/home/pi/mqtt_local_pub_new.sh arduino/esp8266_E0B2A2/ssrda/setpercent 66) &
elif [ "$COMM" == 'Балкон 100%' ] ;then
    ch=$(/home/pi/mqtt_local_pub_new.sh arduino/esp8266_E0B2A2/ssrda/setpercent 100) &
# 100=3квт, 50=1.5квт, 10=300вт, 5=150вт



elif [[ "$COMM" == 'Камера51'* ]] ;then
/home/pi/telegram_sendphoto.sh $user_id /home/pi/html/upload/lastsnap_cam51.jpg lastsnap_cam51 
elif [[ "$COMM" == 'Камера52'* ]] ;then
/home/pi/telegram_sendphoto.sh $user_id /home/pi/html/upload/lastsnap_cam52.jpg lastsnap_cam52

elif [[ "$COMM" == 'Камера41'* ]] ;then
/home/pi/telegram_sendphoto.sh $user_id /home/pi/html/upload/lastsnap_cam41.jpg lastsnap_cam41 
elif [[ "$COMM" == 'Камера42'* ]] ;then
/home/pi/telegram_sendphoto.sh $user_id /home/pi/html/upload/lastsnap_cam42.jpg lastsnap_cam42
elif [[ "$COMM" == 'Камера39'* ]] ;then
#/home/pi/telegram_sendphoto.sh $user_id /mnt/yandex.disk/pi/cam/lastsnap_cam39.jpg lastsnap_cam39 
#/home/pi/motion_cam39.sh 
#/home/pi/telegram_sendphoto.sh $user_id /home/pi/capture39.jpg capture39 
/home/pi/telegram_sendphoto.sh $user_id /home/pi/html/upload/lastsnap_cam39.jpg lastsnap_cam39 
elif [[ "$COMM" == 'Камера33'* ]] ;then
#/home/pi/motion_cam33.sh 
#/home/pi/telegram_sendphoto.sh $user_id /home/pi/capture33.jpg capture33 
/home/pi/telegram_sendphoto.sh $user_id /home/pi/html/upload/lastsnap_cam33.jpg lastsnap_cam33 
elif [[ "$COMM" == 'Камера34'* ]] ;then
#/home/pi/motion_cam34.sh 
#/home/pi/telegram_sendphoto.sh $user_id /home/pi/capture34.jpg capture34 
/home/pi/telegram_sendphoto.sh $user_id /home/pi/html/upload/lastsnap_cam34.jpg lastsnap_cam34 
elif [[ "$COMM" == 'Камера37'* ]] ;then
#/home/pi/motion_cam37.sh 
#/home/pi/telegram_sendphoto.sh $user_id /home/pi/capture37.jpg capture37 
/home/pi/telegram_sendphoto.sh $user_id /home/pi/html/upload/lastsnap_cam37.jpg lastsnap_cam37 
elif [ "$COMM" == 'Запись' ] ;then
/home/pi/telegram_sendmessage.sh $user_id "Запись началась..."
/home/pi/rasp_record.sh /mnt/yandex.disk/pi/cam/$DATE.mp3 15
/home/pi/telegram_sendvoice.sh $user_id /mnt/yandex.disk/pi/cam/$DATE.mp3 $DATE 15
elif [ "$COMM" == '/stop' ] ;then
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"keyboard":['\
'[{"text":"/start"}]'\
'],"resize_keyboard":true} }'
#reply_markup: { remove_keyboard: true }
#c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"remove_keyboard":true,"hide_keyboard":true,"resize_keyboard":true} }'
#c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"remove_keyboard":true,"resize_keyboard":true} }'


elif [[ "$COMM" == 'Температура '* ]] ;then
#TEXT="Температура датчики"
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"inline_keyboard":['\
'[{"text":"Температура датчики","callback_data":"Закрыть"}]'\
',[{"text":"Спальня","callback_data":"Спальня датчики AAA"},{"text":"Темп: '$(/home/pi/mysql_info.sh 41 1)'°" ,"callback_data":"Температура..."},{"text":"Влаж: '$(/home/pi/mysql_info.sh 42 0)'%","callback_data":"Влажность..."}]'\
',[{"text":"Кухня","callback_data":"Кухня..."},{"text":"Темп: '$(/home/pi/mysql_info.sh 31 1)'°" ,"callback_data":"Температура..."},{"text":"Влаж: '$(/home/pi/mysql_info.sh 32 0)'%","callback_data":"Влажность..."}]'\
',[{"text":"Детская","callback_data":"Детская..."},{"text":"Темп: '$(/home/pi/mysql_info.sh 91 1)'°" ,"callback_data":"Температура..."},{"text":"Влаж: '$(/home/pi/mysql_info.sh 92 0)'%","callback_data":"Влажность..."}]'\
',[{"text":"Ванная","callback_data":"Ванная датчики AAA"},{"text":"Темп: '$(/home/pi/mysql_info.sh 81 1)'°" ,"callback_data":"Температура..."},{"text":"Влаж: '$(/home/pi/mysql_info.sh 82 0)'%","callback_data":"Влажность..."}]'\
',[{"text":"Балкон","callback_data":"Балкон..."},{"text":"Темп: '$(/home/pi/mysql_info.sh 71 1)'°" ,"callback_data":"Температура..."},{"text":"Влаж: '$(/home/pi/mysql_info.sh 72 0)'%","callback_data":"Влажность..."}]'\
']} }'


elif [[ "$COMM" == 'Ванная датчики AAA'* ]] ;then
#TEXT="Ванная датчики"
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"inline_keyboard":['\
'[{"text":"Ванная датчики","callback_data":"Закрыть"}]'\
',[{"text":"Ванная","callback_data":"Ванная..."},{"text":"Темп: '$(/home/pi/mysql_info.sh 81 1)'°" ,"callback_data":"Температура..."},{"text":"Влаж: '$(/home/pi/mysql_info.sh 82 0)'%","callback_data":"Влажность..."}]'\
',[{"text":"Свет: '$(/home/pi/mysql_info.sh 108101 0)'" ,"callback_data":"Температура..."},{"text":"Вентилятор: '$(/home/pi/mysql_info.sh 108102 0)'" ,"callback_data":"Температура..."}]'\
',[{"text":"Дверь: '$(/home/pi/mysql_info.sh 401006 0)'" ,"callback_data":"Температура..."},{"text":"Движение: '$(/home/pi/mysql_info.sh 108226 0)'" ,"callback_data":"Температура..."}]'\
',[{"text":"Освещенность: '$(/home/pi/mysql_info.sh 108224 0)'" ,"callback_data":"Температура..."},{"text":"Яркость: '$(/home/pi/mysql_info.sh 108224 0)'" ,"callback_data":"Температура..."}]'\
']} }'


elif [[ "$COMM" == 'Спальня датчики AAA'* ]] ;then
#TEXT="Ванная датчики"
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"inline_keyboard":['\
'[{"text":"Спальня датчики","callback_data":"Закрыть"}]'\
',[{"text":"Спальня","callback_data":"Спальня..."},{"text":"Темп: '$(/home/pi/mysql_info.sh 41 1)'°" ,"callback_data":"Температура..."},{"text":"Влаж: '$(/home/pi/mysql_info.sh 42 0)'%","callback_data":"Влажность..."}]'\
',[{"text":"Свет: '$(/home/pi/mysql_info.sh 107100 0)'" ,"callback_data":"/switch 107100 -1"},{"text":"Левый: '$(/home/pi/mysql_info.sh 107101 0)'" ,"callback_data":"/switch 107101 -1"},{"text":"Центр: '$(/home/pi/mysql_info.sh 107102 0)'" ,"callback_data":"/switch 107102 -1"},{"text":"Правый: '$(/home/pi/mysql_info.sh 107103 0)'" ,"callback_data":"/switch 107103 -1"}]'\
',[{"text":"Свет зеркало: '$(/home/pi/mysql_info_bin.sh 611301 ВКЛ ВЫКЛ)'" ,"callback_data":"/switch 611301 -1"},{"text":"Свет лента: '$(/home/pi/mysql_info_bin.sh 612301 ВКЛ ВЫКЛ)'" ,"callback_data":"/switch 612301 -1"}]'\
',[{"text":"Термостат: '$(/home/pi/mysql_info_bin.sh 104511 ON OFF)'" ,"callback_data":"/switch 104511 2"},{"text":"Целевая: '$(/home/pi/mysql_info.sh 104521 1)'°" ,"callback_data":"Температура..."}]'\
',[{"text":"CO2: '$(/home/pi/mysql_info.sh 104219 0)'" ,"callback_data":"Температура..."},{"text":"Яркость: '$(/home/pi/mysql_info.sh 109244 0)'" ,"callback_data":"Температура..."}]'\
']} }'

elif [[ "$COMM" == '/switch '* ]] ;then
#c_msg_but='{"chat_id":'$user_id', "text":"'$COMM'..."}'
ch=${COMM:8}
ch=$(/home/pi/rasp_switch.sh $ch) &
#/home/pi/telegram_sendmessage.sh $user_id "test $ch"

elif [[ "$COMM" == 'Лампы'* ]] ;then
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"keyboard":['\
'[{"text":"/start"}]'\
',[{"text":"Спальня свет"},{"text":"Спальня бра1"},{"text":"Спальня люстра"},{"text":"Спальня бра3"}]'\
',[{"text":"Кухня свет"},{"text":"Кухня люстра1"},{"text":"Кухня люстра2"},{"text":"Кухня люстра3"}]'\
',[{"text":"/set 106 1"},{"text":"/set 106 0"}]'\
',[{"text":"/set 107 1"},{"text":"/set 107 0"}]'\
']} }'

c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"inline_keyboard":['\
'[{"text":"Закрыть","callback_data":"Закрыть"}]'\
',[{"text":"Спальня свет","callback_data":"Спальня свет"},{"text":"бра1","callback_data":"Спальня бра1"},{"text":"люстра","callback_data":"Спальня люстра"},{"text":"бра3","callback_data":"Спальня бра3"}]'\
',[{"text":"Спальня зеркало","callback_data":"Спальня зеркало"},{"text":"Спальня лента","callback_data":"Спальня лента"}]'\
',[{"text":"Кухня свет","callback_data":"Кухня свет"},{"text":"люстра1","callback_data":"Кухня люстра1"},{"text":"люстра2","callback_data":"Кухня люстра2"},{"text":"люстра3","callback_data":"Кухня люстра3"}]'\
',[{"text":"Prev","callback_data":"Prev"},{"text":"Next","callback_data":"Next"}]'\
']} }'

elif [[ "$COMM" == 'Спальня свет' ]] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Спальня0..."
    ch=$(/home/pi/rasp_switch.sh 107100 2) &
#c_msg_but=$c_msg_but_main
elif [[ "$COMM" == 'Спальня бра1' ]] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Спальня1..."
    ch=$(/home/pi/rasp_switch.sh 107101 -1) &
#c_msg_but=$c_msg_but_main
elif [[ "$COMM" == 'Спальня люстра' ]] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Спальня2..."
    ch=$(/home/pi/rasp_switch.sh 107102 -1) &
#c_msg_but=$c_msg_but_main
elif [[ "$COMM" == 'Спальня бра3' ]] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Спальня3..."
    ch=$(/home/pi/rasp_switch.sh 107103 -1) &
#c_msg_but=$c_msg_but_main
elif [[ "$COMM" == 'Спальня зеркало' ]] ;then
    ch=$(/home/pi/rasp_switch.sh 611301 -1) &
elif [[ "$COMM" == 'Спальня лента' ]] ;then
    ch=$(/home/pi/rasp_switch.sh 612301 -1) &



elif [[ "$COMM" == 'Кухня свет' ]] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Кухня..."
    ch=$(/home/pi/rasp_switch.sh 109100 2) &
#c_msg_but=$c_msg_but_main
elif [[ "$COMM" == 'Кухня люстра1' ]] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Кухня..."
    ch=$(/home/pi/rasp_switch.sh 109101 -1) &
#c_msg_but=$c_msg_but_main
elif [[ "$COMM" == 'Кухня люстра2' ]] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Кухня..."
    ch=$(/home/pi/rasp_switch.sh 109102 -1) &
#c_msg_but=$c_msg_but_main
elif [[ "$COMM" == 'Кухня люстра3' ]] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Кухня..."
    ch=$(/home/pi/rasp_switch.sh 109103 -1) &
#c_msg_but=$c_msg_but_main


elif [ "$COMM" == 'Розетки' ] ;then
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"inline_keyboard":['\
'[{"text":"/start","callback_data":"A1"} ]'\
',[{"text":"РозеткаZ1","callback_data":"/set Z1 2"}, {"text":"РозеткаZ2","callback_data":"/set Z2 2"}, {"text":"РозеткаZ3","callback_data":"/set Z3 2"}]'\
',[{"text":"РозеткаW1","callback_data":"/set W1 2"}, {"text":"РозеткаW2","callback_data":"/set W2 2"}, {"text":"РозеткаW3","callback_data":"/set W3 2"}]'\
',[{"text":"СпальняA0","callback_data":"/set A0 2"}, {"text":"СпальняA1","callback_data":"/set A1 2"}, {"text":"СпальняA2","callback_data":"/set A2 2"}, {"text":"СпальняA3","callback_data":"/set A3 2"}]'\
']} }'
elif [ "$COMM" == '/set A0 2' ] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Розетка set A1 2..."
    ch=$(/home/pi/rasp_switch.sh 107100 2) &
#c_msg_but=$c_msg_but_main
elif [ "$COMM" == '/set A1 2' ] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Розетка set A1 2..."
    ch=$(/home/pi/rasp_switch.sh 107101 -1) &
#c_msg_but=$c_msg_but_main
elif [ "$COMM" == '/set A2 2' ] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Розетка set A1 2..."
    ch=$(/home/pi/rasp_switch.sh 107102 -1) &
#c_msg_but=$c_msg_but_main
elif [ "$COMM" == '/set A3 2' ] ;then
#    /home/pi/telegram_sendmessage.sh $user_id "Розетка set A1 2..."
    ch=$(/home/pi/rasp_switch.sh 107103 -1) &
#c_msg_but=$c_msg_but_main

elif [ "$COMM" == 'Реле' ]
then
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"keyboard":['\
'[{"text":"/start"}]'\
',[{"text":"/set 11 1"},{"text":"/set 11 0"}]'\
',[{"text":"/set 12 1"},{"text":"/set 12 0"}]'\
',[{"text":"/set 13 1"},{"text":"/set 13 0"}]'\
',[{"text":"/set 14 1"},{"text":"/set 14 0"}]'\
',[{"text":"/set 15 1"},{"text":"/set 15 0"}]'\
']} }'
elif [ "$COMM" == 'Тест' ]
then
c_msg_but='{"chat_id":'$user_id', "text":"'$TEXT'...", "reply_markup": {"inline_keyboard":['\
'[{"text":"Включить лампу", "callback_data":"rasp_switch.py 107 1"}]'\
',[{"text":"Выключить лампу", "callback_data":"rasp_switch.py 107 0"}]'\
']} }'
else
# echo "Parameter error"
# exit

#c_msg_but='{"chat_id":'$user_id', "text":"Привет '$user_id'. Выбери...", "reply_markup": {"keyboard":['\
#'[{"text":"/start"}]'\
#']} }'

#/home/pi/open_voice.py "$COMM"
tail=${COMM//\"/\\\"} #заменяю кавычки для передачи в телеграм
#/home/pi/telegram_sendevent_me.sh  "power $tail"
/home/pi/mqtt_local_pub_new.sh "rasp/telegram/send" "$tail" 
fi

if [ "$c_msg_but" != '' ] 
then
#torsocks curl -d "$c_msg_but" -H "Content-Type: application/json" -X POST $c_msg_send --connect-timeout 5
curl -d "$c_msg_but" -H "Content-Type: application/json" -X POST $c_msg_send --connect-timeout 5
echo ""
fi


