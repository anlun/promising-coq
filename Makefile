COQMODULE    := promising 
COQTHEORIES  := src/lib/*.v src/lang/*.v src/while/*.v src/prop/*.v src/drf/*.v src/opt/*.v

.PHONY: all theories clean

all: quick

build: Makefile.coq
	$(MAKE) -f Makefile.coq all

quick: Makefile.coq
	$(MAKE) -f Makefile.coq quick

# sflib: lib/sflib
# 	$(MAKE) -C lib/sflib

# sflib-quick: lib/sflib
# 	$(MAKE) -C lib/sflib quick

# paco: lib/paco/src
# 	$(MAKE) -C lib/paco/src

# paco-quick: lib/paco/src
# 	$(MAKE) -C lib/paco/src quick

Makefile.coq: Makefile $(COQTHEORIES)
	(#echo "-R /usr/lib/coq/user-contrib/sflib sflib"; \
   #echo "-R /usr/lib/coq/user-contrib/paco Paco"; \
   # echo "-R lib/hahn $(COQMODULE)"; \
   \
   echo "-R src/lib $(COQMODULE)"; \
   echo "-R src/lang $(COQMODULE)"; \
   echo "-R src/while $(COQMODULE)"; \
   echo "-R src/prop $(COQMODULE)"; \
   echo "-R src/opt $(COQMODULE)"; \
   echo "-R src/drf $(COQMODULE)"; \
   # echo "-R src/invariant $(COQMODULE)"; \
   # echo "-R src/axiomatic $(COQMODULE)"; \
	\
   echo $(COQTHEORIES)) > _CoqProject
	coq_makefile -f _CoqProject -o Makefile.coq

%.vo: Makefile.coq
	$(MAKE) -f Makefile.coq "$@"

%.vio: Makefile.coq
	$(MAKE) -f Makefile.coq "$@"

clean:
	$(MAKE) -f Makefile.coq clean
	rm -f _CoqProject Makefile.coq
