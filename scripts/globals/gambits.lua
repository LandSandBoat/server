-----------------------------------
-- Gambits decision making system
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------

ai = ai or {}

-- Selectors
ai.s =
{
    SELF   = 0,
    PARTY  = 1,
    TARGET = 2,
}

-- Triggers
ai.t =
{
    HPP_LTE          = 0,
    HPP_GTE          = 1,
    MPP_LTE          = 2,
    TP_GTE           = 3,
    STATUS           = 4,
    NOT_STATUS       = 5,
    STATUS_FLAG      = 6,
    NUKE             = 7,
    SC_AVAILABLE     = 8,
    NOT_SC_AVAILABLE = 9,
    MB_AVAILABLE     = 10,
}

-- Reactions
ai.r =
{
    ATTACK = 0,
    ASSIST = 1,
    MA     = 2,
    JA     = 3,
    WS     = 4,
}

-- Reaction Mods
ai.rm =
{
    SELECT_HIGHEST    = 0,
    SELECT_LOWEST     = 1,
    SELECT_SPECIFIC   = 2,
    SELECT_RANDOM     = 3,
    SELECT_MB_ELEMENT = 4,
}
