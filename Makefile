
NAME		:=	RPZLA

all:	
	@@echo 'choose between data loggers (make loggers) or web site (make web)'

logger:	
	$(MAKE) -C etc install
	$(MAKE) -C bin install

web:
	@@echo 'cd web/analyse ; vi Makefile # set CGI_DIR ; make install'
