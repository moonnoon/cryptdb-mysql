OBJDIRS     += crypto
CRYPTOSRC   := BasicCrypto.cc paillier.cc urandom.cc arc4.cc hgd.cc pbkdf2.cc \
	       ecjoin.cc ECJoin.cc search.cc skip32.cc ffx.cc online_ope.cc mont.cc \
	       prng.cc ope.cc SWPSearch.cc
CRYPTOOBJ   := $(patsubst %.cc,$(OBJDIR)/crypto/%.o,$(CRYPTOSRC))

all:	$(OBJDIR)/libedbcrypto.a $(OBJDIR)/libedbcrypto.so

$(OBJDIR)/libedbcrypto.so: $(CRYPTOOBJ) $(OBJDIR)/libedbutil.so
	$(CXX) -shared -o $@ $(CRYPTOOBJ) $(LDFLAGS) $(LDRPATH) \
	       -ledbutil -lcrypto -lntl

$(OBJDIR)/libedbcrypto.a: $(CRYPTOOBJ)
	$(AR) r $@ $(CRYPTOOBJ)
