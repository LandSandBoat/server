-----------------------------------
-- Gambits decision making system
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------

ai = ai or {}

-- Target
ai.target =
{
    SELF       = 0,
    PARTY      = 1,
    TARGET     = 2,
    MASTER     = 3,
    TANK       = 4,
    MELEE      = 5,
    RANGED     = 6,
    CASTER     = 7,
    TOP_ENMITY = 8,
}
ai.t = ai.target

-- Condition
ai.condition =
{
    ALWAYS             = 0,
    HPP_LT             = 1,
    HPP_GTE            = 2,
    MPP_LT             = 3,
    TP_LT              = 4,
    TP_GTE             = 5,
    STATUS             = 6,
    NOT_STATUS         = 7,
    STATUS_FLAG        = 8,
    HAS_TOP_ENMITY     = 9,
    NOT_HAS_TOP_ENMITY = 10,
    SC_AVAILABLE       = 11,
    NOT_SC_AVAILABLE   = 12,
    MB_AVAILABLE       = 13,
    READYING_WS        = 14,
    READYING_MS        = 15,
    READYING_JA        = 16,
    CASTING_MA         = 17,
    RANDOM             = 18,
}
ai.c = ai.condition

-- Reaction
ai.reaction =
{
    ATTACK  = 0,
    RATTACK = 1,
    MA      = 2,
    JA      = 3,
    WS      = 4,
    MS      = 5,
    MSG     = 6,
}
ai.r = ai.reaction

-- Select
ai.select =
{
    HIGHEST    = 0,
    LOWEST     = 1,
    SPECIFIC   = 2,
    RANDOM     = 3,
    MB_ELEMENT = 4,
    SPECIAL_AYAME = 5,
}
ai.s = ai.select

-- TP Move Trigger
ai.tp =
{
    ASAP   = 0,
    RANDOM = 1,
    OPENER = 2,
    CLOSER = 3,
}
