-----------------------------------
-- LOGGING SETTINGS
-----------------------------------
-- All settings are attached to the `xi.settings` object. This is published globally, and be accessed from C++ and any script.
-----------------------------------

xi = xi or {}
xi.settings = xi.settings or {}

xi.settings.logging =
{
    -- Trace messages are very in-depth details about the internal state of the game.
    -- They should be used instead of random print/printfs in the code.
    --
    -- In Lua: trace(...), in C++: ShowTrace(...)
    ENABLE_TRACE = false,

    -- If ENABLE_TRACE is on, you can further filter down which messages you want to see
    -- by toggling these flags.
    TRACE_NAVMESH            = false,
    TRACE_EVENTS             = false,
    TRACE_COMBAT             = false,
    TRACE_MAGIC_CALCULATIONS = false,
    TRACE_DAMAGE_CALCULATION = false,

    -- In a debug build, this will  be forces to true.
    -- In a release build, it will be set to false (as seen).
    ENABLE_DEBUG = false,

    -- Flush to file frequency

    -- Timestamp format

    -- etc.
}
