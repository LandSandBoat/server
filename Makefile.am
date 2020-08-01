## Set automake options
AUTOMAKE_OPTIONS=foreign

## Gather sourcelist
include sources.am

## Set up all of our dependency flags
SRC_ALL                 = $(SRC_TOPAZ)
CFLAGS_ALL              = $(TOPAZ_CFLAGS) -fsigned-char
CPPFLAGS_ALL            = $(TOPAZ_CPPFLAGS) -fsigned-char -DFMT_HEADER_ONLY -Wall -Werror -Wno-class-memaccess -Wno-restrict -Wno-format-overflow -Wno-sizeof-pointer-memaccess -Wno-maybe-uninitialized -Wno-stringop-truncation -Wno-sign-compare
CXXFLAGS_ALL            = $(TOPAZ_CXXFLAGS) -fsigned-char
LIBS_ALL                = $(TOPAZ_LIBS)
LDFLAGS_ALL             = $(TOPAZ_LDFLAGS)
CXX                     = g++ -std=c++17

CFLAGS_ALL              += $(LUA_CFLAGS)
CFLAGS_ALL              += $(MYSQL_CFLAGS)

LIBS_ALL                += $(LUA_LIBS)
LIBS_ALL                += $(MYSQL_LDFLAGS)
LIBS_ALL                += -lzmq

## Add Architecture-specific stuff
if TOPAZ_ARCH_LINUX
LIBS_ALL                += -ldl -lpthread
endif

if TOPAZ_ARCH_SOLARIS
LIBS_ALL                += -lsocket -lnsl -ldl
endif

if TOPAZ_ARCH_FREEBSD
CPPFLAGS_ALL            += -D__FREEBSD__
endif

if TOPAZ_ARCH_NETBSD
CPPFLAGS_ALL            += -D__NETBSD__
endif

if TOPAZ_ARCH_WIN32
CPPFLAGS_ALL            += -DFD_SETSIZE=4096 -DCYGWIN
endif

if TOPAZ_ARCH_OSX
LDFLAGS_ALL             += -pagezero_size 10000 -image_base 100000000
endif

## Targets
bin_PROGRAMS          = topaz_game topaz_connect topaz_search

topaz_game_SOURCES        = $(SRC_ALL) $(SRC_MAP)
topaz_game_CXXFLAGS       = $(CFLAGS_ALL) $(CXXFLAGS_ALL)
topaz_game_CPPFLAGS       = $(CPPFLAGS_ALL)
topaz_game_CFLAGS         = $(CFLAGS_ALL)
topaz_game_LDFLAGS        = $(LDFLAGS_ALL)
topaz_game_LDADD          = $(LIBS_ALL)

topaz_connect_SOURCES     = $(SRC_ALL) $(SRC_LOGIN)
topaz_connect_CXXFLAGS    = $(CFLAGS_ALL) $(CXXFLAGS_ALL)
topaz_connect_CPPFLAGS    = $(CPPFLAGS_ALL)
topaz_connect_CFLAGS      = $(CFLAGS_ALL)
topaz_connect_LDFLAGS     = $(LDFLAGS_ALL)
topaz_connect_LDADD       = $(LIBS_ALL)

topaz_search_SOURCES     = $(SRC_SEARCH_COMMON) $(SRC_SEARCH)
topaz_search_CXXFLAGS    = $(CFLAGS_ALL) $(CXXFLAGS_ALL)
topaz_search_CPPFLAGS    = $(CPPFLAGS_ALL)
topaz_search_CFLAGS      = $(CFLAGS_ALL)
topaz_search_LDFLAGS     = $(LDFLAGS_ALL)
topaz_search_LDADD       = $(LIBS_ALL)
