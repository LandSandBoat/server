-----------------------------------
-- Gambits decision making system
-----------------------------------

ai = ai or {}

-- Target
ai.target =
{
    SELF                       = 0,
    PARTY                      = 1,
    TARGET                     = 2,
    MASTER                     = 3,
    TANK                       = 4,
    MELEE                      = 5,
    RANGED                     = 6,
    CASTER                     = 7,
    TOP_ENMITY                 = 8,
    CURILLA                    = 9, -- Special case for Rainemard
    PARTY_DEAD                 = 10,
    PARTY_MULTI                = 11,
    TRIGGER_SELF_ACTION_TARGET = 12, -- Triggers get checked on the trust but the action target is the battleTarget
    TRIGGER_TARGET_ACTION_SELF = 13, -- Triggers get checked on the battleTarget but the action target is the trust
}
ai.t = ai.target

-- Logic
ai.logic =
{
    AND = 0,
}

ai.logic.OR = setmetatable(
    { value = 1 },
    {
        __call = function(self, ...)
            local args = { ... }
            local conditions = {}

            for _, condition in ipairs(args) do
                if type(condition) == 'table' then
                    table.insert(conditions, condition)
                else
                    error('ai.logic.OR expects only tables as arguments, got ' .. type(condition))
                end
            end

            return {
                logic = self.value,
                conditions = conditions,
            }
        end,
    }
)
ai.l = ai.logic

-- Condition
ai.condition =
{
    ALWAYS             = 0,
    HPP_LT             = 1,
    HPP_GTE            = 2,
    MPP_LT             = 3,
    MPP_GTE            = 4,
    TP_LT              = 5,
    TP_GTE             = 6,
    LVL_LT             = 7,
    LVL_GTE            = 8,
    STATUS             = 9,
    NOT_STATUS         = 10,
    STATUS_FLAG        = 11,
    HAS_TOP_ENMITY     = 12,
    NOT_HAS_TOP_ENMITY = 13,
    SC_AVAILABLE       = 14,
    NOT_SC_AVAILABLE   = 15,
    MB_AVAILABLE       = 16,
    READYING_WS        = 17,
    READYING_MS        = 18,
    READYING_JA        = 19,
    CASTING_MA         = 20,
    CASTING_DEBUFF     = 21,
    RANDOM             = 22,
    NO_SAMBA           = 23,
    NO_STORM           = 24,
    PT_HAS_TANK        = 25,
    NOT_PT_HAS_TANK    = 26,
    IS_ECOSYSTEM       = 27,
    HP_MISSING         = 28,
    CASTING_ELEMENT_MA = 29,
    CAST_ELE_MA_SELF   = 30,
    CASTING_ELE_MA_AOE = 31,
    NEED_ELE_BAREFFECT = 32,
    NO_MAX_RUNE        = 33,
    HAS_RUNES          = 34,
    LUNGE_MB_AVAILABLE = 35,
    SUB_ANIMATION      = 36,
    JA_ON_COOLDOWN     = 37,
    VAL_URIEL_CHECK    = 38,
    TIMER              = 39, -- argument in seconds
}
ai.c = ai.condition

-- Reaction
ai.reaction =
{
    ATTACK      = 0,
    RATTACK     = 1,
    MA          = 2,
    JA          = 3,
    WS          = 4,
    MS          = 5,
    ANIM_STRING = 6,
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
    SPECIAL_AUGUST      = 6,
    BEST_AGAINST_TARGET = 7,
    BEST_SAMBA          = 8,
    HIGHEST_WALTZ       = 9,
    ENTRUSTED           = 10,
    BEST_INDI           = 11,
    STORM_DAY           = 12,
    HELIX_DAY           = 13,
    EN_MOB_WEAKNESS     = 14,
    STORM_MOB_WEAKNESS  = 15,
    HELIX_MOB_WEAKNESS  = 16,
    DEF_BAR_ELEMENT     = 17,
    RUNE_DAY            = 18,
    RANDOM_ANIMATION    = 19,
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
