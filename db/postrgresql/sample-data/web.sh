#!/bin/bash

export IFS=';'

while read dt ip client host
do
	echo "insert into web values (DEFAULT, '$dt', '$ip', '$client', '$host');" 
done <<- EOHereDoc
2012-02-06 00:01:01;1.2.3.4;host1.org;1.nasty.com
2012-02-06 00:01:31;1.2.3.5;host2.org;2.nasty.com
2012-02-10 00:01:01;1.2.3.4;host1.org;1.nasty.com
2012-02-10 00:01:31;1.2.3.5;host2.org;2.nasty.com
2012-02-10 00:02:01;1.2.3.4;host1.org;1.nasty.com
2012-02-10 00:02:31;1.2.3.5;host2.org;2.nasty.com
2012-02-11 00:01:01;1.2.3.4;host1.org;1.nasty.com
2012-02-11 00:01:31;1.2.3.5;host2.org;3.nasty.com
2012-02-11 00:02:01;1.2.3.4;host1.org;1.nasty.com
2012-02-11 00:02:31;1.2.3.5;host2.org;3.nasty.com
2012-02-12 00:00:11;1.2.3.6;host3.org;4.nasty.com
2012-02-12 00:00:21;1.2.3.6;host3.org;4.nasty.com
2012-02-12 00:00:31;1.2.3.6;host3.org;4.nasty.com
2012-02-12 00:00:41;1.2.3.6;host3.org;4.nasty.com
2012-02-12 00:00:51;1.2.3.6;host3.org;4.nasty.com
2012-02-12 00:01:01;1.2.3.6;host3.org;4.nasty.com
EOHereDoc
