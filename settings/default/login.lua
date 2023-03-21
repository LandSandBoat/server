-----------------------------------
-- LOGIN SERVER SETTINGS
-----------------------------------
-- All settings are attached to the `xi.settings` object. This is published globally, and be accessed from C++ and any script.
--
-- This file is concerned mainly with logging into the game, and managing login sessions.
-----------------------------------

xi = xi or {}
xi.settings = xi.settings or {}

xi.settings.login =
{
    -- Expected Client version (wrong version cannot log in)
    CLIENT_VER = "30230304_1",

    -- 0 - disabled (every version allowed)
    -- 1 - enabled - strict (only exact CLIENT_VER allowed)
    -- 2 - enabled - greater than or equal  (matching or greater than CLIENT_VER allowed, default)
    --
    -- WE STRONGLY ADVISE AGAINST LOCKING THE SERVER TO OLDER VERSIONS. IT IS A UNIVERSALLY BAD IDEA.
    VER_LOCK = 2,

    -- 0 - disabled (normal operation)
    -- 1 - enabled (only GM characters allowed online, no new character creation)
    MAINT_MODE = 0,

    -- Logging of user IP address to database (true/false)
    LOG_USER_IP = false,

    -- Allow account creation via the loader (true/false)
    ACCOUNT_CREATION = true,

    -- Allow character deletion through the lobby (true/false)
    CHARACTER_DELETION = true,

    -- Number of simultaneous game sessions per IP (0 for no limit)
    LOGIN_LIMIT = 0,

    -- If true, blocks character creation with names of NPCs and Mobs in the database (Fafnir, Shantotto, etc.)
    DISABLE_MOB_NPC_CHAR_NAMES = false,

    -- Character names with any of these words in, in any position, will be rejected
    --
    -- Examples that will be rejected (using "badword"):
    -- "badword"
    -- "imbadword"
    -- "badwordisme"
    -- "lolbadwordlol"
    --
    -- WARNING:
    -- Be aware of the "Scunthorpe problem"!
    --
    -- NOTE:
    -- You can Google for "bad word list txt" to find lists of words to populate this table, if you'd like
    BANNED_WORDS_LIST =
    {
        "badword",
    }
}
