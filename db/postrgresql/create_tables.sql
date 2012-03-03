
CREATE SEQUENCE dns_id MINVALUE 0\g

CREATE TABLE dns
(
	id INTEGER DEFAULT nextval('dns_id') PRIMARY KEY,
	datetime TIMESTAMP,
	client_ip VARCHAR(39),	   -- max length of an IPv6 (colon separated)
	query_domain VARCHAR(120), -- hoping there are no domains longer ...
	response_zone VARCHAR(120) -- hoping there are no domains longer ...
)\g

CREATE SEQUENCE web_id MINVALUE 0\g

CREATE TABLE web
(
	id INTEGER DEFAULT nextval('web_id') PRIMARY KEY,
	datetime TIMESTAMP,
	client_ip VARCHAR(39),	    -- max length of an IPv6 (colon separated)
	client_hostname VARCHAR(80),-- hoping there are no hostnames longer ...
	query_domain VARCHAR(120) -- hoping there are no domains longer ...
)\g


