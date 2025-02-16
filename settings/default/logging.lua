-----------------------------------
-- LOGGING SETTINGS
-----------------------------------
-- All settings are attached to the `xi.settings` object. This is published globally, and be accessed from C++ and any script.
--
-- This file is concerned mainly with configuring the logging across all server executables.
-----------------------------------

xi = xi or {}
xi.settings = xi.settings or {}

xi.settings.logging =
{
    --[[
        # General pattern to be used by spdlog

        ## Additional custom flags:
        %& : the exe type name (login, map, search, world)
        %_ : the first letter of the exe type name (L, M, S, W)
        %* : a fixed-length (32) and right-truncated function name + file line number
        %q : a fixed-length (32) and right-truncated file name + file line number

        "Classic" pattern : "[%D %T:%e][%&]%^[%n]%$ %v (%!:%#)"
        [12/03/22 19:25:12:812][map][info] do_init: connecting to database (do_init:221)
        [12/03/22 19:25:12:815][map][info] database client version: 3.2.8 (do_init:224)
        [12/03/22 19:25:12:815][map][info] database server version: 10.6.10-MariaDB (do_init:225)
        [12/03/22 19:25:12:815][map][info] luautils: Lua initializing (luautils::init:113)

        "New" pattern : "%Y/%m/%d %T:%e | %_ | %^%-4!l%$ | %* | %v"
        2022/12/03 19:24:08:984 | M | info |                      do_init:221 | do_init: connecting to database
        2022/12/03 19:24:08:987 | M | info |                      do_init:224 | database client version: 3.2.8
        2022/12/03 19:24:08:987 | M | info |                      do_init:225 | database server version: 10.6.10-MariaDB
        2022/12/03 19:24:08:987 | M | info |               luautils::init:113 | luautils: Lua initializing

        ## Docs:
        https://spdlog.docsforge.com/v1.x/3.custom-formatting/
    --]]
    PATTERN = "[%D %T:%e][%&]%^[%n]%$ %v (%!:%#)",

    -- Enable/Disable these logging types globally
    LOG_DEBUG   = true,
    LOG_INFO    = true,
    LOG_WARNING = true,
    LOG_LUA     = true, -- Prints from Lua using `print()`

    -- Specific Debug loggers
    -- NOTE: None of these will print unless you also have the above LOG_DEBUG setting set to true!
    DEBUG_SOCKETS        = false, -- Calls in C++: DebugSockets(...)
    DEBUG_NAVMESH        = false, -- Calls in C++: DebugNavmesh(...)
    DEBUG_PACKETS        = false, -- Calls in C++: DebugPackets(...)
    DEBUG_ACTIONS        = false, -- Calls in C++: DebugActions(...)
    DEBUG_SQL            = false, -- Calls in C++: DebugSQL(...)
    DEBUG_ID_LOOKUP      = false, -- Calls in C++: DebugIDLookup(...)
    DEBUG_MODULES        = false, -- Calls in C++: DebugModules(...)
    DEBUG_PACKET_BACKLOG = false, -- Special logic in map.cpp::send_parse
    DEBUG_AUCTIONS       = false, -- Special logic in auctionutils.cpp
    DEBUG_DELIVERY_BOX   = false, -- Special logic in dboxutils.cpp
    DEBUG_BAZAARS        = false, -- Additional debug logs for bazaar interactions in packet_system.cpp

    SQL_SLOW_QUERY_LOG_ENABLE   = true, -- true/false. If true, slow SQL queries will generate warning or error logs if they exceed the durations listed below.
    SQL_SLOW_QUERY_WARNING_TIME = 100,  -- uint (milliseconds).
    SQL_SLOW_QUERY_ERROR_TIME   = 250,  -- uint (milliseconds).
}
