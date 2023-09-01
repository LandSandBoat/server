-----------------------------------
-- Gambits decision making system
-----------------------------------
require('scripts/globals/utils')
-----------------------------------

ai = ai or {}

-- Target
ai.target =
{
    SELF        = 0,
    PARTY       = 1,
    TARGET      = 2,
    MASTER      = 3,
    TANK        = 4,
    MELEE       = 5,
    RANGED      = 6,
    CASTER      = 7,
    TOP_ENMITY  = 8,
    CURILLA     = 9, -- Special case for Rainemard
    PARTY_DEAD  = 10,
    PARTY_MULTI = 11,
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
    NO_SAMBA           = 19,
    NO_STORM           = 20,
    PT_HAS_TANK        = 21,
    NOT_PT_HAS_TANK    = 22,
    IS_ECOSYSTEM       = 23,
    HP_MISSING         = 24,
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
}
ai.r = ai.reaction

-- Select
ai.select =
{
    HIGHEST             = 0,
    LOWEST              = 1,
    SPECIFIC            = 2,
    RANDOM              = 3,
    MB_ELEMENT          = 4,
    SPECIAL_AYAME       = 5,
    BEST_AGAINST_TARGET = 6,
    BEST_SAMBA          = 7,
    HIGHEST_WALTZ       = 8,
    ENTRUSTED           = 9,
    BEST_INDI           = 10,
    STORM_DAY           = 11,
    HELIX_DAY           = 12,
}
ai.s = ai.select

-- TP Move Trigger
ai.tp =
{
    ASAP            = 0,
    RANDOM          = 1,
    OPENER          = 2,
    CLOSER          = 3,    -- Will Hold TP Indefinitely to close a SC
    CLOSER_UNTIL_TP = 4,    -- Will Hold TP to close a SC until a certain threshold
}
