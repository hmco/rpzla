/*
 *  The views are a heirarchy of summaries of the data
 *
 * (dns|web)_(day|week|month)
 *
 * provide a time limited view of the data
 *
 * (dns|web)_(day|week|month)_all
 *
 * provide the same, but exclude the id column
 *
 * (dns|web)_(day|week|month)_frequency
 *
 * SELECT data in the period AND GROUP BY the client_ip to show
 * how many connections there have been by each client.
 *
 */
CREATE VIEW dns_day AS 
	SELECT * FROM dns WHERE date(now()) - date(datetime) <= 1;
CREATE VIEW dns_week AS 
	SELECT * FROM dns WHERE date(now()) - date(datetime) <= 7;
CREATE VIEW dns_month AS 
	SELECT * FROM dns WHERE date(now()) - date(datetime) <= 30;

CREATE VIEW dns_day_trunc AS
	SELECT  date_trunc('day', datetime), count(datetime), 
		client_ip, query_domain, response_zone
	FROM dns_day
	GROUP BY date_trunc('day', datetime), client_ip, query_domain, response_zone
	ORDER BY date_trunc('day', datetime) DESC;

CREATE VIEW dns_week_trunc AS
	SELECT  date_trunc('week', datetime), count(datetime), 
		client_ip, query_domain, response_zone
	FROM dns_week
	GROUP BY date_trunc('week', datetime), client_ip, query_domain, response_zone
	ORDER BY date_trunc('week', datetime) DESC;

CREATE VIEW dns_month_trunc AS
	SELECT  date_trunc('month', datetime), count(datetime), 
		client_ip, query_domain, response_zone
	FROM dns_month 
	GROUP BY date_trunc('month', datetime), client_ip, query_domain, response_zone
	ORDER BY date_trunc('month', datetime) DESC;

CREATE VIEW dns_day_frequency AS
	SELECT min(datetime) as "min(datetime)", count(*), client_ip 
	FROM dns_day
	GROUP BY client_ip
	ORDER BY count(*) DESC;

CREATE VIEW dns_week_frequency AS
	SELECT min(datetime) as "min(datetime)", count(*), client_ip 
	FROM dns_week
	GROUP BY client_ip
	ORDER BY count(*) DESC;

CREATE VIEW dns_month_frequency AS
	SELECT min(datetime) as "min(datetime)", count(*), client_ip 
	FROM dns_month
	GROUP BY client_ip
	ORDER BY count(*) DESC;

CREATE VIEW dns_day_all AS
	SELECT datetime, client_ip, query_domain, response_zone 
	FROM dns_day
	ORDER BY datetime DESC;

CREATE VIEW dns_week_all AS
	SELECT datetime, client_ip, query_domain, response_zone 
	FROM dns_week
	ORDER BY datetime DESC;

CREATE VIEW dns_month_all AS
	SELECT datetime, client_ip, query_domain, response_zone 
	FROM dns_month
	ORDER BY datetime DESC;

CREATE VIEW web_day AS 
	SELECT * 
	FROM web 
	WHERE date(now()) - date(datetime) <= 1;

CREATE VIEW web_week AS 
	SELECT * 
	FROM web 
	WHERE date(now()) - date(datetime) <= 7;

CREATE VIEW web_month AS 
	SELECT * 
	FROM web 
	WHERE date(now()) - date(datetime) <= 30;

CREATE VIEW web_day_trunc AS
	SELECT  date_trunc('day', datetime), count(datetime), 
		client_ip, client_hostname, query_domain
	FROM web_day
	GROUP BY date_trunc('day', datetime), client_ip, 
		client_hostname, query_domain
	ORDER BY date_trunc('day', datetime) DESC;

CREATE VIEW web_week_trunc AS
	SELECT  date_trunc('week', datetime), count(datetime), 
		client_ip, client_hostname, query_domain
	FROM web_week
	GROUP BY date_trunc('week', datetime), client_ip, 
		client_hostname, query_domain
	ORDER BY date_trunc('week', datetime) DESC;

CREATE VIEW web_month_trunc AS
	SELECT  date_trunc('month', datetime), count(datetime), 
		client_ip, client_hostname, query_domain
	FROM web_month
	GROUP BY date_trunc('month', datetime), client_ip, 
		client_hostname, query_domain
	ORDER BY date_trunc('month', datetime) DESC;

CREATE VIEW web_day_frequency AS
	SELECT min(datetime) as "min(datetime)", count(*), 
		client_hostname, client_ip
	FROM web_day
	GROUP BY client_hostname, client_ip
	ORDER BY count(*), client_hostname, client_ip DESC;

CREATE VIEW web_week_frequency AS
	SELECT min(datetime) as "min(datetime)", count(*), 
		client_hostname, client_ip
	FROM web_week
	GROUP BY client_hostname, client_ip
	ORDER BY count(*), client_hostname, client_ip DESC;

CREATE VIEW web_month_frequency AS
	SELECT min(datetime) as "min(datetime)", count(*),
		client_hostname, client_ip
	FROM web_month
	GROUP BY client_hostname, client_ip
	ORDER BY count(*), client_hostname, client_ip DESC;

CREATE VIEW web_day_all AS
	SELECT datetime, client_hostname, client_ip, query_domain 
	FROM web_day
	ORDER BY datetime DESC;

CREATE VIEW web_week_all AS
	SELECT datetime, client_hostname, client_ip, query_domain 
	FROM web_week
	ORDER BY datetime DESC;

CREATE VIEW web_month_all AS
	SELECT datetime, client_hostname, client_ip, query_domain 
	FROM web_month
	ORDER BY datetime DESC;

/*
 * Correlated data: matches between dns AND web (data grouped into 'buckets'
 * of time by use of the _trunc views).
 */
CREATE VIEW cor_day_web AS
	SELECT d.date_trunc, d.count, d.client_ip, 
		w.client_hostname, d.query_domain
	FROM dns_day_trunc d, web_day_trunc w
	WHERE d.date_trunc = w.date_trunc AND
		d.client_ip = w.client_ip AND
		d.query_domain = w.query_domain
	GROUP BY d.date_trunc, d.count, d.client_ip, 
		w.client_hostname, d.query_domain
	ORDER BY d.date_trunc DESC, d.count DESC;

CREATE VIEW cor_week_web AS
	SELECT d.date_trunc, d.count, d.client_ip, 
		w.client_hostname, d.query_domain
	FROM dns_week_trunc d, web_week_trunc w
	WHERE d.date_trunc = w.date_trunc AND
		d.client_ip = w.client_ip AND
		d.query_domain = w.query_domain
	GROUP BY d.date_trunc, d.count, d.client_ip, 
		w.client_hostname, d.query_domain
	ORDER BY d.date_trunc DESC, d.count DESC;

CREATE VIEW cor_month_web AS
	SELECT d.date_trunc, d.count, d.client_ip, 
		w.client_hostname, d.query_domain
	FROM dns_month_trunc d, web_month_trunc w
	WHERE d.date_trunc = w.date_trunc AND
		d.client_ip = w.client_ip AND
		d.query_domain = w.query_domain
	GROUP BY d.date_trunc, d.count, d.client_ip, 
		w.client_hostname, d.query_domain
	ORDER BY d.date_trunc DESC, d.count DESC;

/*
 * Not correlated: dns record but no matching web record
 */

CREATE VIEW cor_day_dns AS
	SELECT d.date_trunc, d.count, d.client_ip, 
		d.query_domain, d.response_zone
	FROM dns_day_trunc d 
	WHERE not exists
	( 
		SELECT 1 
		FROM web_day_trunc w
		WHERE d.date_trunc = w.date_trunc AND 
			d.client_ip = w.client_ip AND 
			d.query_domain = w.query_domain
	) 
	ORDER BY d.date_trunc DESC, d.count DESC, d.client_ip DESC;

CREATE VIEW cor_week_dns AS
	SELECT d.date_trunc, d.count, 
		d.client_ip, d.query_domain, d.response_zone
	FROM dns_week_trunc d 
	WHERE not exists
	( 
		SELECT 1 
		FROM web_week_trunc w
		WHERE d.date_trunc = w.date_trunc AND 
			d.client_ip = w.client_ip AND 
			d.query_domain = w.query_domain
	) 
	ORDER BY d.date_trunc DESC, d.count DESC, d.client_ip DESC;

CREATE VIEW cor_month_dns AS
	SELECT d.date_trunc, d.count, 
		d.client_ip, d.query_domain, d.response_zone
	FROM dns_month_trunc d 
	WHERE not exists
	( 
		SELECT 1 
		FROM web_month_trunc w
		WHERE d.date_trunc = w.date_trunc AND 
			d.client_ip = w.client_ip AND 
			d.query_domain = w.query_domain
	) 
	ORDER BY d.date_trunc DESC, d.count DESC, d.client_ip DESC;

