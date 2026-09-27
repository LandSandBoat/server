target_sources(xi_profile_lib PRIVATE
    bytes.h
    codec.cpp
    codec.h
    sq_pol_character_primitive.h
    sq_pol_message_header.h
)

add_subdirectory(irc)
add_subdirectory(profile)
