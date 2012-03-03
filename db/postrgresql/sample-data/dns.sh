#!/bin/bash

export IFS=';'

while read dt ip host zone
do
	echo "insert into dns values (DEFAULT, '$dt', '$ip', '$host', '$zone');" 
done <<- EOHereDoc
2012-02-06 00:01:00;1.2.3.4;1.nasty.com;rpz.provider.com
2012-02-06 00:01:30;1.2.3.5;2.nasty.com;rpz.me.com
2012-02-10 00:01:00;1.2.3.4;1.nasty.com;rpz.provider.com
2012-02-10 00:01:30;1.2.3.5;2.nasty.com;rpz.me.com
2012-02-10 00:01:31;1.2.3.5;2.malware.com;rpz.provider.com
2012-02-10 00:02:00;1.2.3.4;1.nasty.com;rpz.provider.com
2012-02-10 00:02:30;1.2.3.5;2.nasty.com;rpz.me.com
2012-02-10 00:02:31;1.2.3.5;2.malware.com;rpz.provider.com
2012-02-11 00:01:00;1.2.3.4;1.nasty.com;rpz.provider.com
2012-02-11 00:01:30;1.2.3.5;3.nasty.com;rpz.provider.com
2012-02-11 00:01:31;1.2.3.5;3.malware.com;rpz.provider.com
2012-02-11 00:02:00;1.2.3.4;1.nasty.com;rpz.provider.com
2012-02-11 00:02:30;1.2.3.5;3.nasty.com;rpz.provider.com
2012-02-12 00:00:10;1.2.3.6;4.nasty.com;rpz.provider.com
2012-02-12 00:00:20;1.2.3.6;4.nasty.com;rpz.provider.com
2012-02-12 00:00:30;1.2.3.6;4.nasty.com;rpz.provider.com
2012-02-12 00:00:40;1.2.3.6;4.nasty.com;rpz.provider.com
2012-02-12 00:00:50;1.2.3.6;4.nasty.com;rpz.provider.com
2012-02-12 00:01:00;1.2.3.6;4.nasty.com;rpz.provider.com
EOHereDoc
