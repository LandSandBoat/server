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
    DEBUG_SOCKETS        = false,
    DEBUG_NAVMESH        = false,
    DEBUG_PACKETS        = false,
    DEBUG_ACTIONS        = false,
    DEBUG_SQL            = false,
    DEBUG_ID_LOOKUP      = false,
    DEBUG_MODULES        = false,
    DEBUG_PACKET_BACKLOG = false,
}
