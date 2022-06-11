-----------------------------------
-- LOGIN SERVER SETTINGS
-----------------------------------
-- All settings are attached to the `xi.settings` object. This is published globally, and be accessed from C++ and any script.
-----------------------------------

xi = xi or {}
xi.settings = xi.settings or {}

xi.settings.login =
{
    -- Logging of user IP address to database (true/false)
    LOG_USER_IP = false,

    -- Allow account creation via the loader (true/false)
    ACCOUNT_CREATION = true,

    -- Allow character deletion through the lobby (true/false)
    CHARACTER_DELETION = true,
}
