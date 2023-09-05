-----------------------------------
-- These codes represent the subeffects for
-- additional effects animations from battleentity.h
-----------------------------------
xi = xi or {}

xi.subEffect =
{
    -- ATTACKS
    FIRE_DAMAGE         = 1,   -- 110000        3
    ICE_DAMAGE          = 2,   -- 1-01000       5
    WIND_DAMAGE         = 3,   -- 111000        7
    CHOKE               = 3,   -- Shares subeffect
    EARTH_DAMAGE        = 4,   -- 1-00100       9
    LIGHTNING_DAMAGE    = 5,   -- 110100       11
    WATER_DAMAGE        = 6,   -- 1-01100      13
    LIGHT_DAMAGE        = 7,   -- 111100       15
    DARKNESS_DAMAGE     = 8,   -- 1-00010      17
    DISPEL              = 8,   -- Verified with video of Lockheart Greatsword proc.
    SLEEP               = 9,   -- 110010       19
    POISON              = 10,  -- 1-01010      21
    ADDLE               = 11,  -- Verified shared group 1
    AMNESIA             = 11,  -- Verified shared group 1
    PARALYSIS           = 11,  -- Verified shared group 1
    BLIND               = 12,  -- 1-00110      25
    SILENCE             = 13,
    PETRIFY             = 14,
    PLAGUE              = 15,
    STUN                = 16,
    CURSE               = 17,
    DEFENSE_DOWN        = 18,  -- 1-01001      37
    EVASION_DOWN        = 18,  -- Verified shared group 2
    ATTACK_DOWN         = 18,  -- Verified shared group 2
    SLOW                = 18,  -- Verified shared group 2
    DEATH               = 19,
    SHIELD              = 20,
    HP_DRAIN            = 21,  -- 1-10101      43
    MP_DRAIN            = 22,  -- Verified shared group 3
    TP_DRAIN            = 22,  -- Verified shared group 3
    HASTE               = 23,
    -- There are no additional attack effect animations beyond 23. Some effects share subeffect/animations.

    -- SPIKES
    BLAZE_SPIKES        = 1,   -- 01-1000       6
    ICE_SPIKES          = 2,   -- 01-0100      10
    DREAD_SPIKES        = 3,   -- 01-1100      14
    CURSE_SPIKES        = 4,   -- 01-0010      18
    SHOCK_SPIKES        = 5,   -- 01-1010      22
    REPRISAL            = 6,   -- 01-0110      26
    GLINT_SPIKES        = 6,   --
    GALE_SPIKES         = 7,   -- Used by enchantment "Cool Breeze" http://www.ffxiah.com/item/22018/
    CLOD_SPIKES         = 8,   --
    DELUGE_SPIKES       = 9,   --
    DEATH_SPIKES        = 10,  -- yes really: http://www.ffxiah.com/item/26944/
    COUNTER             = 63,
    -- There are no spikes effect animations beyond 63. Some effects share subeffect/animations.
    -- "Damage Spikes" use the Blaze Spikes animation even though they are different status.

    -- SKILLCHAINS
    NONE                = 0,
    LIGHT               = 1,
    DARKNESS            = 2,
    GRAVITATION         = 3,
    FRAGMENTATION       = 4,
    DISTORTION          = 5,
    FUSION              = 6,
    COMPRESSION         = 7,
    LIQUEFACATION       = 8,
    INDURATION          = 9,
    REVERBERATION       = 10,
    TRANSFIXION         = 11,
    SCISSION            = 12,
    DETONATION          = 13,
    IMPACTION           = 14,
}
