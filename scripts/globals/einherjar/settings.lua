-----------------------------------
-- Einherjar: Settings
-----------------------------------
xi = xi or {}
xi.einherjar = xi.einherjar or {}

-- Retail defaults
xi.einherjar.settings = {
    -- Should Einherjar be enabled? Entry gate interactions disabled if false
    EINHERJAR_ENABLED = xi.settings.main.EINHERJAR_ENABLED or false,

    -- Minimum level required to reserve and enter Einherjar
    EINHERJAR_LEVEL_MIN = xi.settings.main.EINHERJAR_LEVEL_MIN or 60,

    -- Smoldering lamp cost from Kilusha. Cost with ROV KI is fixed at 1000g.
    SMOLDERING_LAMP_BASE_COST = xi.settings.main.SMOLDERING_LAMP_BASE_COST or 60000,

    -- How long before a player can reenter Einherjar, in hours. Reentry with ROV KI is fixed at 1 hour.
    EINHERJAR_REENTRY_TIME = xi.settings.main.EINHERJAR_REENTRY_TIME or 20,

    -- How long before all players are expelled from the chamber when wiped
    EINHERJAR_KO_EXPEL_TIME = xi.settings.main.EINHERJAR_KO_EXPEL_TIME or 3,

    -- How long a chamber reservation is valid for, in minutes.
    EINHERJAR_TIME_LIMIT = xi.settings.main.EINHERJAR_TIME_LIMIT or 30,

    -- Multiplier for awarded Therion Ichor.
    EINHERJAR_ICHOR_RATE = xi.settings.main.EINHERJAR_ICHOR_RATE or 1.0,

    -- How long until a reservation is released if the player does not enter, in minutes.
    EINHERJAR_RESERVATION_TIMEOUT = xi.settings.main.EINHERJAR_RESERVATION_TIMEOUT or 3,

    -- How many players can enter a chamber before it is considered full
    EINHERJAR_MAX_PLAYERS_PER_CHAMBER = xi.settings.main.EINHERJAR_MAX_PLAYERS_PER_CHAMBER or 36,

    -- How long before the chamber kicks everyone out after the chest has been opened.
    EINHERJAR_CLEAR_EXTRA_TIME = xi.settings.main.EINHERJAR_CLEAR_EXTRA_TIME or 5,
}
