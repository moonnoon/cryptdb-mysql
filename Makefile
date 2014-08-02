OBJDIR	 := obj
TOP	 := $(shell echo $${PWD-`pwd`})
CXX	 := g++
AR	 := ar
## -g -O0 -> -O2
CXXFLAGS := -g -O0 -fno-strict-aliasing -fno-rtti -fwrapv -fPIC \
	    -Wall -Werror -Wpointer-arith -Wendif-labels -Wformat=2  \
	    -Wextra -Wmissing-noreturn -Wwrite-strings -Wno-unused-parameter \
	    -Wno-deprecated \
	    -Wmissing-declarations -Woverloaded-virtual  \
	    -Wunreachable-code -D_GNU_SOURCE -std=c++0x -I$(TOP)
LDFLAGS  := -L$(TOP)/$(OBJDIR) -Wl,--no-undefined

## Copy conf/config.mk.sample to conf/config.mk and adjust accordingly.
#include conf/config.mk

## Use RPATH only for debug builds; set RPATH=1 in config.mk.
ifeq ($(RPATH),1)
LDRPATH	 := -Wl,-rpath=$(TOP)/$(OBJDIR) -Wl,-rpath=$(TOP)
endif

CXXFLAGS += -I$(MYBUILD)/include \
	    -I$(MYSRC)/include \
	    -I$(MYSRC)/sql \
	    -I$(MYSRC)/regex \
	    -I$(MYBUILD)/sql \
	    -DHAVE_CONFIG_H -DMYSQL_SERVER -DEMBEDDED_LIBRARY -DDBUG_OFF \
	    -DMYSQL_BUILD_DIR=\"$(MYBUILD)\"
LDFLAGS	 += -lpthread -lrt -ldl -lcrypt -lreadline

## To be populated by Makefrag files

OBJDIRS	:=

.PHONY: all
all:

.PHONY: install
install:

.PHONY: clean
clean:
	rm -rf $(OBJDIR)

.PHONY: doc
doc:
	doxygen CryptDBdoxgen

.PHONY: whitespace
whitespace:
	find . -name '*.cc' -o -name '*.hh' -type f -exec sed -i 's/ *$//' '{}' ';'

.PHONY: always
always:

# Eliminate default suffix rules
.SUFFIXES:

# Delete target files if there is an error (or make is interrupted)
.DELETE_ON_ERROR:

# make it so that no intermediate .o files are ever deleted
.PRECIOUS: %.o

$(OBJDIR)/%.o: %.cc
	@mkdir -p $(@D)
	$(CXX) -MD $(CXXFLAGS) -c $< -o $@

$(OBJDIR)/%.o: $(OBJDIR)/%.cc
	@mkdir -p $(@D)
	$(CXX) -MD $(CXXFLAGS) -c $< -o $@

include crypto/Makefile
include util/Makefile
include udf/Makefile
