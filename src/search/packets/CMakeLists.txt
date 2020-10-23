set(SOURCES
    auction_history.cpp
    auction_history.h
    auction_list.cpp
    auction_list.h
    linkshell_list.cpp
    linkshell_list.h
    party_list.cpp
    party_list.h
    search_comment.cpp
    search_comment.h
    search_list.cpp
    search_list.h)

add_library(search_packets OBJECT ${SOURCES})