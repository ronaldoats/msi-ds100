
INSTALL = /usr/bin/install -c
INSTALLDATA = /usr/bin/install -c -m 644
PROGNAME = ds100
CFLAGS = -lhidapi
UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)
        CFLAGS += -DOSX `pkg-config --cflags hidapi`
        LDFLAGS = `pkg-config --libs hidapi`
else
        ifeq ($(UNAME), Linux)
                LDFLAGS = `pkg-config hidapi-libusb --libs`
        endif
endif

all: $(PROGNAME)

$(PROGNAME): $(PROGNAME).c
        $(CC) $(PROGNAME).c  -o $(PROGNAME) $(CFLAGS) $(LDFLAGS)

install: all
        $(INSTALL) $(PROGNAME) /usr/bin

clean:
        rm -f $(PROGNAME) *.o
