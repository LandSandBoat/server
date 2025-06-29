-----------------------------------
-- TESTS SETTINGS
-----------------------------------
-- All settings are attached to the `xi.settings` object. This is published globally, and be accessed from C++ and any script.
--
-- This file is concerned mainly with test behavior.
-----------------------------------

xi = xi or {}
xi.settings = xi.settings or {}

-- These are overrides for the test environment.
xi.settings.test =
{
    logging =
    {
        -- Default condensed format for test logs.
        PATTERN     = '[%T][%^%-4!l%$][%*] %v',

        -- Overrides global log level.
        LOG_DEBUG   = true,
        LOG_INFO    = true,
        LOG_WARNING = true,
        LOG_LUA     = true, -- Prints from Lua using `print()`
    },

    main =
    {
        NEW_CHARACTER_CUTSCENE      = false,
        DISABLE_INACTIVITY_WATCHDOG = true,
    },
}
