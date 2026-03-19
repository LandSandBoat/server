-----------------------------------
-- Gambits decision making system
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
    STATUS             = 7,
    NOT_STATUS         = 8,
    STATUS_FLAG        = 9,
    HAS_TOP_ENMITY     = 10,
    NOT_HAS_TOP_ENMITY = 11,
    SC_AVAILABLE       = 12,
    NOT_SC_AVAILABLE   = 13,
    MB_AVAILABLE       = 14,
    READYING_WS        = 15,
    READYING_MS        = 16,
    READYING_JA        = 17,
    CASTING_MA         = 18,
    RANDOM             = 19,
    NO_SAMBA           = 20,
    NO_STORM           = 21,
    PT_HAS_TANK        = 22,
    NOT_PT_HAS_TANK    = 23,
    IS_ECOSYSTEM       = 24,
    HP_MISSING         = 25,
    CASTING_ELEMENT_MA = 26,
    CAST_ELE_MA_SELF   = 27,
    CASTING_ELE_MA_AOE = 28,
    NEED_ELE_BAREFFECT = 29,
    NO_MAX_RUNE        = 30,
    HAS_RUNES          = 31,
    LUNGE_MB_AVAILABLE = 32,
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
    EN_MOB_WEAKNESS     = 13,
    STORM_MOB_WEAKNESS  = 14,
    HELIX_MOB_WEAKNESS  = 15,
    DEF_BAR_ELEMENT     = 16,
    RUNE_DAY            = 17,
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
