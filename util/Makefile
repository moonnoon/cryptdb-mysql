OBJDIRS += util
UTILSRC := onions.cc cryptdb_log.cc ctr.cc util.cc version.cc

all:    $(OBJDIR)/libedbutil.so $(OBJDIR)/libedbutil.a

$(OBJDIR)/libedbutil.so: $(patsubst %.cc,$(OBJDIR)/util/%.o,$(UTILSRC))
	$(CXX) -shared -o $@ $^ $(LDFLAGS) -lntl -lcrypto -lgmp

$(OBJDIR)/libedbutil.a: $(patsubst %.cc,$(OBJDIR)/util/%.o,$(UTILSRC))
	$(AR) r $@ $^

$(OBJDIR)/util/version.cc: always
	@mkdir -p $(@D)
	@echo "#include <util/version.hh>" > $@.tmp
	@( REL="$$(git describe --always --long --dirty=+dirty)" ; \
	  echo "const char* cryptdb_version_string = \"$$REL\";" >> $@.tmp )
	@cmp -s $@.tmp $@ || mv $@.tmp $@
