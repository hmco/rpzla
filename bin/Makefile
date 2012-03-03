
INSTALL		:=	install -m 755
BIN_DIR		:=	/usr/local/bin

BIN_SRCS	:=	\
			rpzla-apache-filter.pl	\
			rpzla-apache.sh		\
			rpzla-apache-to-db.pl		\
			rpzla-bind-filter.pl		\
			rpzla-bind.sh			\
			rpzla-bind-to-db.pl

BIN_TARGETS	:=	$(BIN_SRCS:%=$(BIN_DIR)/%)

# ------------------------
# Targets
# ------------------------

all:		install

install:	$(BIN_TARGETS)

clean:		
	@echo "You mean clobber"

clobber:
	rm -f $(BIN_TARGETS)

$(BIN_DIR)/%:	%
	$(INSTALL) $< $@
