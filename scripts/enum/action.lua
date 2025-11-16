-----------------------------------
-- Action packet
-----------------------------------
xi = xi or {}
xi.action = xi.action or {}

-- action.cmd_no (4 bits)
-- Type of the action packet.
-- Client processes each type in a different fashion.
---@enum xi.action.category
xi.action.category =
{
    NONE                  = 0,
    BASIC_ATTACK          = 1,
    RANGED_FINISH         = 2,
    WEAPONSKILL_FINISH    = 3,
    MAGIC_FINISH          = 4,
    ITEM_FINISH           = 5,
    JOBABILITY_FINISH     = 6,
    WEAPONSKILL_START     = 7,
    MAGIC_START           = 8,
    ITEM_START            = 9,
    JOBABILITY_START      = 10,
    MOBABILITY_FINISH     = 11,
    RANGED_START          = 12,
    PET_MOBABILITY_FINISH = 13,
    DANCER                = 14, -- Used by various Steps and Flourishes
    RUNEFENCER            = 15, -- Used by various RUN abilities

    -- Everything below this line is 100% made-up
    -- and has nothing to do with actual action packets
    ROAMING               = 16,
    ENGAGE                = 17,
    DISENGAGE             = 18,
    CHANGE_TARGET         = 19,
    FALL                  = 20,
    DROPITEMS             = 21,
    DEATH                 = 22,
    FADE_OUT              = 23,
    DESPAWN               = 24,
    SPAWN                 = 25,
    STUN                  = 26,
    SLEEP                 = 27,
    ITEM_USING            = 28,
    ITEM_INTERRUPT        = 29,
    MAGIC_CASTING         = 30,
    MAGIC_INTERRUPT       = 31,
    RANGED_INTERRUPT      = 32,
    MOBABILITY_START      = 33,
    MOBABILITY_USING      = 34,
    MOBABILITY_INTERRUPT  = 35,
    LEAVE                 = 36,
    RAISE_MENU_SELECTION  = 37,
    JOBABILITY_INTERRUPT  = 38,
}

-- action.result.miss (3 bits)
-- Denotes final resolution of the attack.
-- Only one may be set.
---@enum xi.action.resolution
xi.action.resolution =
{
    HIT   = 0,
    MISS  = 1,
    GUARD = 2,
    PARRY = 3,
    BLOCK = 4,
}

-- action.result.info (5 bits)
-- Multiple flags can be set.
-- For DNC and RUN abilities, they represent animations.
---@enum xi.action.info
xi.action.info =
{
    NONE               = 0,
    DEFEATED           = 1,
    CRITICAL_HIT       = 2,
    UNKNOWN_AOE        = 4,

    -- Dancer animations
    -- Only for action packets cmd_no 14
    -- Substract 4 for equivalent miss animation.
    WILD_FLOURISH      = 5,
    QUICK_STEP         = 5,
    BOX_STEP           = 6,
    DESPERATE_FLOURISH = 6,
    STUTTER_STEP       = 7,
    VIOLENT_FLOURISH   = 7,
    FEATHER_STEP       = 8,

    -- Rune Fencer rune elements
    -- Only for action packets cmd_no 15
    ELEMENTAL_MIX      = 0, -- Used when ability mixes several runes
    IGNIS              = 1,
    GELUS              = 2,
    FLABRA             = 3,
    TELLUS             = 4,
    SUPLOR             = 5,
    UNDO               = 6,
    LUX                = 7,
    TENEBRAE           = 8,
}

-- action.result.scale (5 bits, upper 3 bits shared with distortion)
-- Notify the client of any knockback effect that must occur.
---@enum xi.action.knockback
xi.action.knockback =
{
    NONE   = 0,
    LEVEL1 = 1, -- Vec: 0.083, Dumper: 0.075, Timer: 5.0
    LEVEL2 = 2, -- Vec: 0.167, Dumper: 0.15, Timer: 5.0
    LEVEL3 = 3, -- Vec: 0.167, Dumper: 0.15, Timer: 10.0
    LEVEL4 = 4, -- Vec: 0.167, Dumper: 0.15, Timer: 18.0
    LEVEL5 = 5, -- Vec: 0.167, Dumper: 0.125, Timer: 30.0
    LEVEL6 = 6, -- Vec: 0.167, Dumper: 0.1, Timer: 35.0
    LEVEL7 = 7, -- Vec: 0.167, Dumper: 0.05, Timer: 45.0
}

-- action.result.scale (5 bits, lower 2 bits, shared with knockback)
-- Represents how much the defender recoils after being hit.
---@enum xi.action.hitDistortion
xi.action.hitDistortion =
{
    NONE   = 0,
    LIGHT  = 1, -- 0.25 distortion
    MEDIUM = 2, -- 0.5 distortion
    HEAVY  = 3, -- 1.0 distortion
}

-- action.result.bit (31 bits)
-- Modifiers applied to the ability message/result/animation
---@enum xi.action.modifier
xi.action.modifier =
{
    NONE         = 0,
    COVER        = 1,
    RESIST       = 2,
    MAGIC_BURST  = 4,
    IMMUNOBREAK  = 8,
    CRITICAL_HIT = 16,
}

-- action.result.proc_kind (6 bits)
-- Represents additional effects or skillchains
---@enum xi.action.addEffect
xi.action.addEffect =
{
    NONE             = 0,
    FIRE_DAMAGE      = 1,
    ICE_DAMAGE       = 2,
    WIND_DAMAGE      = 3,
    EARTH_DAMAGE     = 4,
    LIGHTNING_DAMAGE = 5,
    WATER_DAMAGE     = 6,
    LIGHT_DAMAGE     = 7,
    DARK_DAMAGE      = 8,
    SLEEP            = 9,
    POISON           = 10,
    PARALYZE         = 11,
    ADDLE            = 11,
    AMNESIA          = 11,
    BLIND            = 12,
    SILENCE          = 13,
    PETRIFY          = 14,
    PLAGUE           = 15,
    STUN             = 16,
    CURSE            = 17,
    WEAKEN           = 18,
    DEFENSE_DOWN     = 18,
    EVASION_DOWN     = 18,
    ATTACK_DOWN      = 18,
    SLOW             = 18,
    DEATH            = 19,
    SHIELD           = 20,
    HP_DRAIN         = 21,
    MP_DRAIN         = 22,
    TP_DRAIN         = 22,
    STATUS_DRAIN     = 22,
    HASTE            = 23,
}

-- action.result.proc_kind (6 bits)
-- Represents additional effects or skillchains
---@enum xi.action.skillchain
xi.action.skillchain =
{
    NONE          = 0,
    LIGHT         = 1,
    DARKNESS      = 2,
    GRAVITATION   = 3,
    FRAGMENTATION = 4,
    DISTORTION    = 5,
    FUSION        = 6,
    COMPRESSION   = 7,
    LIQUEFACTION  = 8,
    INDURATION    = 9,
    REVERBERATION = 10,
    TRANSFIXION   = 11,
    SCISSION      = 12,
    DETONATION    = 13,
    IMPACTION     = 14,
    RADIANCE      = 15,
    UMBRA         = 16,
}

-- action.result.react_kind (6 bits)
-- Represents spikes and counters
---@enum xi.action.react
xi.action.react =
{
    NONE            = 0,
    BLAZE_SPIKES    = 1,
    ICE_SPIKES      = 2,
    DREAD_SPIKES    = 3,
    CURSE_SPIKES    = 4,
    SHOCK_SPIKES    = 5,
    REPRISAL_SPIKES = 6,
    WIND_SPIKES     = 7,
    EARTH_SPIKES    = 8,
    WATER_SPIKES    = 9,
    DEATH_SPIKES    = 10,
    COUNTER         = 63, -- Also used by Retaliation
}
