-----------------------------------
-- Song Utilities
-----------------------------------
require('scripts/globals/jobpoints')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.spells = xi.spells or {}
xi.spells.enhancing = xi.spells.enhancing or {}
-----------------------------------
-- File structure:
-- 2 Basic Functions called by the main function.

local column =
{
    EFFECT_TIER       =  1,
    EFFECT_MAIN       =  2,
    EFFECT_SUB        =  3,
    MODIFIER          =  4,
    MERIT_ID          =  5,
    JOB_POINT_ID      =  6,
    POWER_BASE        =  7,
    SKILL_REQUIREMENT =  8,
    POWER_CAP         =  9,
    MULTIPLIER        = 10,
    DIVISOR           = 11,
    SOUL_VOICE        = 12,
}

-- Table variables.
local pTable =
{
--                                          1     2                 3                         4                       5                         6                     7     8    9    10   11  12
-- Structure:                 [spellId] = { Tier, Main Effect,      subEffect,                Main Modifier,          Merit Effect,             Job-Point Effect,     power Sreq Pcap Mult Div SVP },
    -- Ballad
    [xi.magic.spell.MAGES_BALLAD      ] = { 1, xi.effect.BALLAD,    xi.mod.AUGMENT_SONG_STAT, xi.mod.BALLAD_EFFECT,   0,                        0,                    1,   0,   1,   1,  0, true  },
    [xi.magic.spell.MAGES_BALLAD_II   ] = { 2, xi.effect.BALLAD,    xi.mod.AUGMENT_SONG_STAT, xi.mod.BALLAD_EFFECT,   0,                        0,                    2,   0,   2,   1,  0, true  },
    [xi.magic.spell.MAGES_BALLAD_III  ] = { 3, xi.effect.BALLAD,    xi.mod.AUGMENT_SONG_STAT, xi.mod.BALLAD_EFFECT,   0,                        0,                    3,   0,   3,   1,  0, true  },
    -- Carol - NOTE: CAROL II Gives a fixed elemental evasion. However, it also gives a Elemental Nullification effect, that follows regular song rules concerning power.
    [xi.magic.spell.FIRE_CAROL        ] = { 1, xi.effect.CAROL,     xi.element.FIRE,          xi.mod.CAROL_EFFECT,    0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.ICE_CAROL         ] = { 1, xi.effect.CAROL,     xi.element.ICE,           xi.mod.CAROL_EFFECT,    0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.WIND_CAROL        ] = { 1, xi.effect.CAROL,     xi.element.WIND,          xi.mod.CAROL_EFFECT,    0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.EARTH_CAROL       ] = { 1, xi.effect.CAROL,     xi.element.EARTH,         xi.mod.CAROL_EFFECT,    0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.LIGHTNING_CAROL   ] = { 1, xi.effect.CAROL,     xi.element.THUNDER,       xi.mod.CAROL_EFFECT,    0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.WATER_CAROL       ] = { 1, xi.effect.CAROL,     xi.element.WATER,         xi.mod.CAROL_EFFECT,    0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.LIGHT_CAROL       ] = { 1, xi.effect.CAROL,     xi.element.LIGHT,         xi.mod.CAROL_EFFECT,    0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.DARK_CAROL        ] = { 1, xi.effect.CAROL,     xi.element.DARK,          xi.mod.CAROL_EFFECT,    0,                        0,                   20, 200,  80,   8, 10, true  },
    -- [xi.magic.spell.FIRE_CAROL_II     ] = { 2, xi.effect.CAROL_II,  xi.element.FIRE,        xi.mod.ETUDE_EFFECT,    0,                        0,                   10, 400,  15, 1.5, 10, true  },
    -- [xi.magic.spell.ICE_CAROL_II      ] = { 2, xi.effect.CAROL_II,  xi.element.ICE,         xi.mod.ETUDE_EFFECT,    0,                        0,                   10, 400,  15, 1.5, 10, true  },
    -- [xi.magic.spell.WIND_CAROL_II     ] = { 2, xi.effect.CAROL_II,  xi.element.WIND,        xi.mod.ETUDE_EFFECT,    0,                        0,                   10, 400,  15, 1.5, 10, true  },
    -- [xi.magic.spell.EARTH_CAROL_II    ] = { 2, xi.effect.CAROL_II,  xi.element.EARTH,       xi.mod.ETUDE_EFFECT,    0,                        0,                   10, 400,  15, 1.5, 10, true  },
    -- [xi.magic.spell.LIGHTNING_CAROL_II] = { 2, xi.effect.CAROL_II,  xi.element.THUNDER,     xi.mod.ETUDE_EFFECT,    0,                        0,                   10, 400,  15, 1.5, 10, true  },
    -- [xi.magic.spell.WATER_CAROL_II    ] = { 2, xi.effect.CAROL_II,  xi.element.WATER,       xi.mod.ETUDE_EFFECT,    0,                        0,                   10, 400,  15, 1.5, 10, true  },
    -- [xi.magic.spell.LIGHT_CAROL_II    ] = { 2, xi.effect.CAROL_II,  xi.element.LIGHT,       xi.mod.ETUDE_EFFECT,    0,                        0,                   10, 400,  15, 1.5, 10, true  },
    -- [xi.magic.spell.DARK_CAROL_II     ] = { 2, xi.effect.CAROL_II,  xi.element.DARK,        xi.mod.ETUDE_EFFECT,    0,                        0,                   10, 400,  15, 1.5, 10, true  },
    -- Etude
    [xi.magic.spell.SINEWY_ETUDE      ] = { 1, xi.effect.ETUDE,     xi.mod.STR,               xi.mod.ETUDE_EFFECT,    0,                        0,                    3,   0,   9,   1,  0, true  },
    [xi.magic.spell.DEXTROUS_ETUDE    ] = { 1, xi.effect.ETUDE,     xi.mod.DEX,               xi.mod.ETUDE_EFFECT,    0,                        0,                    3,   0,   9,   1,  0, true  },
    [xi.magic.spell.VIVACIOUS_ETUDE   ] = { 1, xi.effect.ETUDE,     xi.mod.VIT,               xi.mod.ETUDE_EFFECT,    0,                        0,                    3,   0,   9,   1,  0, true  },
    [xi.magic.spell.QUICK_ETUDE       ] = { 1, xi.effect.ETUDE,     xi.mod.AGI,               xi.mod.ETUDE_EFFECT,    0,                        0,                    3,   0,   9,   1,  0, true  },
    [xi.magic.spell.LEARNED_ETUDE     ] = { 1, xi.effect.ETUDE,     xi.mod.INT,               xi.mod.ETUDE_EFFECT,    0,                        0,                    3,   0,   9,   1,  0, true  },
    [xi.magic.spell.SPIRITED_ETUDE    ] = { 1, xi.effect.ETUDE,     xi.mod.MND,               xi.mod.ETUDE_EFFECT,    0,                        0,                    3,   0,   9,   1,  0, true  },
    [xi.magic.spell.ENCHANTING_ETUDE  ] = { 1, xi.effect.ETUDE,     xi.mod.CHR,               xi.mod.ETUDE_EFFECT,    0,                        0,                    3,   0,   9,   1,  0, true  },
    [xi.magic.spell.HERCULEAN_ETUDE   ] = { 2, xi.effect.ETUDE,     xi.mod.STR,               xi.mod.ETUDE_EFFECT,    0,                        0,                   12,   0,  15,   1,  0, true  },
    [xi.magic.spell.UNCANNY_ETUDE     ] = { 2, xi.effect.ETUDE,     xi.mod.DEX,               xi.mod.ETUDE_EFFECT,    0,                        0,                   12,   0,  15,   1,  0, true  },
    [xi.magic.spell.VITAL_ETUDE       ] = { 2, xi.effect.ETUDE,     xi.mod.VIT,               xi.mod.ETUDE_EFFECT,    0,                        0,                   12,   0,  15,   1,  0, true  },
    [xi.magic.spell.SWIFT_ETUDE       ] = { 2, xi.effect.ETUDE,     xi.mod.AGI,               xi.mod.ETUDE_EFFECT,    0,                        0,                   12,   0,  15,   1,  0, true  },
    [xi.magic.spell.SAGE_ETUDE        ] = { 2, xi.effect.ETUDE,     xi.mod.INT,               xi.mod.ETUDE_EFFECT,    0,                        0,                   12,   0,  15,   1,  0, true  },
    [xi.magic.spell.LOGICAL_ETUDE     ] = { 2, xi.effect.ETUDE,     xi.mod.MND,               xi.mod.ETUDE_EFFECT,    0,                        0,                   12,   0,  15,   1,  0, true  },
    [xi.magic.spell.BEWITCHING_ETUDE  ] = { 2, xi.effect.ETUDE,     xi.mod.CHR,               xi.mod.ETUDE_EFFECT,    0,                        0,                   12,   0,  15,   1,  0, true  },
    -- Madrigal: ADMITEDLY MADE UP IN ORIGINAL SCRIPT
    [xi.magic.spell.SWORD_MADRIGAL    ] = { 1, xi.effect.MADRIGAL,  xi.mod.AUGMENT_SONG_STAT, xi.mod.MADRIGAL_EFFECT, xi.merit.MADRIGAL_EFFECT, 0,                    5,  85,  45, 4.5, 18, true  },
    [xi.magic.spell.BLADE_MADRIGAL    ] = { 2, xi.effect.MADRIGAL,  xi.mod.AUGMENT_SONG_STAT, xi.mod.MADRIGAL_EFFECT, xi.merit.MADRIGAL_EFFECT, 0,                    9, 130,  60,   6, 18, true  },
    -- Mambo: ADMITEDLY MADE UP IN ORIGINAL SCRIPT
    [xi.magic.spell.SHEEPFOE_MAMBO    ] = { 1, xi.effect.MAMBO,     xi.mod.AUGMENT_SONG_STAT, xi.mod.MAMBO_EFFECT,    0,                        0,                    5,  85,  48,   5, 18, true  },
    [xi.magic.spell.DRAGONFOE_MAMBO   ] = { 2, xi.effect.MAMBO,     xi.mod.AUGMENT_SONG_STAT, xi.mod.MAMBO_EFFECT,    0,                        0,                    9, 130,  48,   7, 18, true  },
    -- March
    [xi.magic.spell.ADVANCING_MARCH   ] = { 1, xi.effect.MARCH,     xi.mod.AUGMENT_SONG_STAT, xi.mod.MARCH_EFFECT,    0,                        0,                   35, 200, 108,  11,  7, true  },
    [xi.magic.spell.VICTORY_MARCH     ] = { 2, xi.effect.MARCH,     xi.mod.AUGMENT_SONG_STAT, xi.mod.MARCH_EFFECT,    0,                        0,                   43, 300, 163,  16,  7, true  },
    [xi.magic.spell.HONOR_MARCH       ] = { 3, xi.effect.MARCH,     xi.mod.AUGMENT_SONG_STAT, xi.mod.MARCH_EFFECT,    0,                        0,                   24, 400, 126,  12,  7, true  }, -- Not an error. It is weaker.
    -- Minne: Skill Caps unknown?
    [xi.magic.spell.KNIGHTS_MINNE     ] = { 1, xi.effect.MINNE,     xi.mod.AUGMENT_SONG_STAT, xi.mod.MINNE_EFFECT,    xi.merit.MINNE_EFFECT,    xi.jp.MINNE_EFFECT,   8,   0,  30,   3, 10, true  },
    [xi.magic.spell.KNIGHTS_MINNE_II  ] = { 2, xi.effect.MINNE,     xi.mod.AUGMENT_SONG_STAT, xi.mod.MINNE_EFFECT,    xi.merit.MINNE_EFFECT,    xi.jp.MINNE_EFFECT,  12,   0,  69,   7, 10, true  },
    [xi.magic.spell.KNIGHTS_MINNE_III ] = { 3, xi.effect.MINNE,     xi.mod.AUGMENT_SONG_STAT, xi.mod.MINNE_EFFECT,    xi.merit.MINNE_EFFECT,    xi.jp.MINNE_EFFECT,  18,   0, 108,  11, 10, true  },
    [xi.magic.spell.KNIGHTS_MINNE_IV  ] = { 4, xi.effect.MINNE,     xi.mod.AUGMENT_SONG_STAT, xi.mod.MINNE_EFFECT,    xi.merit.MINNE_EFFECT,    xi.jp.MINNE_EFFECT,  30,   0, 164,  16, 10, true  },
    [xi.magic.spell.KNIGHTS_MINNE_V   ] = { 5, xi.effect.MINNE,     xi.mod.AUGMENT_SONG_STAT, xi.mod.MINNE_EFFECT,    xi.merit.MINNE_EFFECT,    xi.jp.MINNE_EFFECT,  50,   0, 204,  20, 10, true  },
    -- Minuet
    [xi.magic.spell.VALOR_MINUET      ] = { 1, xi.effect.MINUET,    xi.mod.AUGMENT_SONG_STAT, xi.mod.MINUET_EFFECT,   xi.merit.MINUET_EFFECT,   xi.jp.MINUET_EFFECT,  5,  50,  32,  3, 4.3, true  }, -- skill cap 163: (163 - 50)/4.3 + 5 ~31
    [xi.magic.spell.VALOR_MINUET_II   ] = { 2, xi.effect.MINUET,    xi.mod.AUGMENT_SONG_STAT, xi.mod.MINUET_EFFECT,   xi.merit.MINUET_EFFECT,   xi.jp.MINUET_EFFECT, 10, 100,  64,  6, 3.9, true  }, -- skill cap 310: (310 - 100)/3.9 + 10 ~64
    [xi.magic.spell.VALOR_MINUET_III  ] = { 3, xi.effect.MINUET,    xi.mod.AUGMENT_SONG_STAT, xi.mod.MINUET_EFFECT,   xi.merit.MINUET_EFFECT,   xi.jp.MINUET_EFFECT, 24, 200,  96,  9, 3.5, true  }, -- skill cap 455: (455 - 200)/3.5 + 24 ~96
    [xi.magic.spell.VALOR_MINUET_IV   ] = { 4, xi.effect.MINUET,    xi.mod.AUGMENT_SONG_STAT, xi.mod.MINUET_EFFECT,   xi.merit.MINUET_EFFECT,   xi.jp.MINUET_EFFECT, 31, 300, 112, 11, 3.3, true  }, -- skill cap 570: (570 - 300)/3.3 + 31 ~112
    [xi.magic.spell.VALOR_MINUET_V    ] = { 5, xi.effect.MINUET,    xi.mod.AUGMENT_SONG_STAT, xi.mod.MINUET_EFFECT,   xi.merit.MINUET_EFFECT,   xi.jp.MINUET_EFFECT, 32, 500, 124, 12,   4, true  }, -- skill cap 874: (874 - 500)/4 + 32 ~124
    -- Paeon
    [xi.magic.spell.ARMYS_PAEON       ] = { 1, xi.effect.PAEON,     xi.mod.AUGMENT_SONG_STAT, xi.mod.PAEON_EFFECT,    0,                        0,                    1, 100,   2,   1,  0, true  },
    [xi.magic.spell.ARMYS_PAEON_II    ] = { 2, xi.effect.PAEON,     xi.mod.AUGMENT_SONG_STAT, xi.mod.PAEON_EFFECT,    0,                        0,                    2, 150,   3,   1,  0, true  },
    [xi.magic.spell.ARMYS_PAEON_III   ] = { 3, xi.effect.PAEON,     xi.mod.AUGMENT_SONG_STAT, xi.mod.PAEON_EFFECT,    0,                        0,                    3, 200,   4,   1,  0, true  },
    [xi.magic.spell.ARMYS_PAEON_IV    ] = { 4, xi.effect.PAEON,     xi.mod.AUGMENT_SONG_STAT, xi.mod.PAEON_EFFECT,    0,                        0,                    4, 250,   5,   1,  0, true  },
    [xi.magic.spell.ARMYS_PAEON_V     ] = { 5, xi.effect.PAEON,     xi.mod.AUGMENT_SONG_STAT, xi.mod.PAEON_EFFECT,    0,                        0,                    5, 350,   7,   1,  0, true  },
    [xi.magic.spell.ARMYS_PAEON_VI    ] = { 6, xi.effect.PAEON,     xi.mod.AUGMENT_SONG_STAT, xi.mod.PAEON_EFFECT,    0,                        0,                    6, 450,   8,   1,  0, true  },
    -- Prelude
    [xi.magic.spell.HUNTERS_PRELUDE   ] = { 1, xi.effect.PRELUDE,   xi.mod.AUGMENT_SONG_STAT, xi.mod.PRELUDE_EFFECT,  0,                        0,                   10,  85,  45, 4.5, 18, true  },
    [xi.magic.spell.ARCHERS_PRELUDE   ] = { 2, xi.effect.PRELUDE,   xi.mod.AUGMENT_SONG_STAT, xi.mod.PRELUDE_EFFECT,  0,                        0,                   20, 130,  60,   6, 18, true  },
    -- Status effect resistance: Aubade, Capriccio, Gavotte, Operetta, Pastoral,
    [xi.magic.spell.FOWL_AUBADE       ] = { 1, xi.effect.AUBADE,    xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.GOLD_CAPRICCIO    ] = { 1, xi.effect.CAPRICCIO, xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.GOBLIN_GAVOTTE    ] = { 1, xi.effect.GAVOTTE,   xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.SCOPS_OPERETTA    ] = { 1, xi.effect.OPERETTA,  xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.PUPPETS_OPERETTA  ] = { 2, xi.effect.OPERETTA,  xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   40, 200, 120,   8, 10, true  },
    [xi.magic.spell.HERB_PASTORAL     ] = { 1, xi.effect.PASTORAL,  xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.SHINING_FANTASIA  ] = { 1, xi.effect.FANTASIA,  xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   20, 200,  80,   8, 10, true  },
    [xi.magic.spell.WARDING_ROUND     ] = { 1, xi.effect.ROUND,     xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   20, 200,  80,   8, 10, true  },
    -- Misc.
    [xi.magic.spell.GODDESSS_HYMNUS   ] = { 1, xi.effect.HYMNUS,    xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                    1,   0,   1,   0,  0, false },
    [xi.magic.spell.SENTINELS_SCHERZO ] = { 1, xi.effect.SCHERZO,   xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                    1, 350,  45,   1, 10, false },
    [xi.magic.spell.RAPTOR_MAZURKA    ] = { 1, xi.effect.MAZURKA,   xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                    5,   0,  12,   0,  0, false },
    [xi.magic.spell.CHOCOBO_MAZURKA   ] = { 1, xi.effect.MAZURKA,   xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   10,   0,  24,   0,  0, false },

    -- Emnity Songs
    [xi.magic.spell.FOE_SIRVENTE      ] = { 1, xi.effect.SIRVENTE,  xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   35,   0,  35,   1,  0, true  },
    [xi.magic.spell.ADVENTURERS_DIRGE ] = { 1, xi.effect.DIRGE,     xi.mod.AUGMENT_SONG_STAT, 0,                      0,                        0,                   32,   0,  32,   0,  0, true  },
}

-- Enhancing Song Potency function. (1/2)
xi.spells.enhancing.calculateSongPower = function(caster, target, spell, spellId, tier, songEffect, instrumentBoost, soulVoicePower)
    local power       = pTable[spellId][column.POWER_BASE] -- The variable we want to calculate.
    local meritEffect = pTable[spellId][column.MERIT_ID]
    local jpEffect    = pTable[spellId][column.JOB_POINT_ID]
    local skillNeeded = pTable[spellId][column.SKILL_REQUIREMENT]
    local potencyCap  = pTable[spellId][column.POWER_CAP]
    local multiplier  = pTable[spellId][column.MULTIPLIER]
    local divisor     = pTable[spellId][column.DIVISOR]
    local singingLvl  = caster:getSkillLevel(xi.skill.SINGING)

    if caster:isPC() then
        -- Add ranged skill level ONLY if it's an instrument.
        local rangeType = caster:getWeaponSkillType(xi.slot.RANGED)

        -- String instruments have half the skill effectiveness and amplify the AoE in exchange.
        if rangeType == xi.skill.WIND_INSTRUMENT then
            singingLvl = singingLvl + caster:getSkillLevel(rangeType)
        elseif rangeType == xi.skill.STRING_INSTRUMENT then
            singingLvl = singingLvl + math.floor(caster:getSkillLevel(rangeType) / 2)
        end
    else
        singingLvl = singingLvl * 2
    end

    -- Get Potency bonuses from Singing Skill and Instrument Skill. TODO: Investigate JP-Wiki. Most of this makes no sense.
    -- NOTE: Tier 1 Etudes.
    if songEffect == xi.effect.ETUDE and tier == 1 then
        if singingLvl >= 450 then
            power = power + 6
        elseif singingLvl >= 397 then
            power = power + 5
        elseif singingLvl >= 343 then
            power = power + 4
        elseif singingLvl >= 289 then
            power = power + 3
        elseif singingLvl >= 236 then
            power = power + 2
        elseif singingLvl >= 182 then
            power = power + 1
        end
    -- NOTE: Tier 2 Etudes.
    elseif songEffect == xi.effect.ETUDE and tier == 2 then
        if singingLvl >= 475 then
            power = power + 3
        elseif singingLvl >= 446 then
            power = power + 2
        elseif singingLvl >= 417 then
            power = power + 1
        end
    -- Other songs.
    else
        if singingLvl > skillNeeded then
            -- NOTE: Paeon
            if divisor == 0 then
                if skillNeeded > 0 then
                    power = power + 1
                end
            -- NOTE: Aubade, Capriccio, Gavotte, Madrigal, March, Minne, Minuet, Operetta, Pastoral, Prelude, Round.
            else
                power = math.floor(power + (singingLvl - skillNeeded) / divisor)
            end
        end

        -- NOTE: Ballad, Hymnus, Mazurka have constant base power.
    end

    -- Apply Cap to power. (Applied before Merits, Job-Points and Status-Effects)
    if power > potencyCap then
        power = potencyCap
    end

    -- Instrument song boost. (All Songs +X, SONG_NAME +X)
    power = math.floor(power + instrumentBoost * multiplier)

    -- Additional Potency from Merits.
    if meritEffect ~= 0 then
        power = math.floor(power + caster:getMerit(meritEffect))
    end

    -- Additional Potency from Job Points.
    if jpEffect ~= 0 then
        power = math.floor(power + caster:getJobPointLevel(jpEffect))
    end

    -- Additional Potency from Status Effects.
    if soulVoicePower then -- Soul Voice/Macarato affects Power.
        if caster:hasStatusEffect(xi.effect.SOUL_VOICE) then
            power = math.floor(power * 2)
        elseif caster:hasStatusEffect(xi.effect.MARCATO) then
            power = math.floor(power * 1.5)
        end
    end

    -- EXCEPTION: AUGMENT_SONG_STAT works differently for etudes, becouse they already boost an stat. And becouse we can't have anything be straightforward in this game.
    if songEffect == xi.effect.ETUDE then
        power = power + caster:getMod(xi.mod.AUGMENT_SONG_STAT)
    end

    -- Finish
    return power
end

-- Enhancing Song Duration function. (2/2)
xi.spells.enhancing.calculateSongDuration = function(caster, target, spell, instrumentBoost, soulVoicePower)
    local duration = 120 -- The variable we want to calculate.

    -- Additional duration from "Song Bonus" (from instruments) and "Duration Bonus" Modifier
    duration = math.floor(duration * ((instrumentBoost * 0.1) + (caster:getMod(xi.mod.SONG_DURATION_BONUS) / 100) + 1))

    -- Additional duration from Job points.
    if caster:hasStatusEffect(xi.effect.CLARION_CALL) then
        duration = math.floor(duration + caster:getJobPointLevel(xi.jp.CLARION_CALL_EFFECT) * 2)
    end

    if caster:hasStatusEffect(xi.effect.MARCATO) then
        duration = math.floor(duration + caster:getJobPointLevel(xi.jp.MARCATO_EFFECT))
        caster:delStatusEffect(xi.effect.MARCATO)
    end

    if caster:hasStatusEffect(xi.effect.TENUTO) then
        duration = math.floor(duration + caster:getJobPointLevel(xi.jp.TENUTO_EFFECT) * 2)
    end

    -- Additional duration from Status Effects.
    if not soulVoicePower then -- Soul Voice/Macarato doesn't affect potency, so it affects Duration.
        if caster:hasStatusEffect(xi.effect.SOUL_VOICE) then
            duration = math.floor(duration * 2)
        elseif caster:hasStatusEffect(xi.effect.MARCATO) then
            duration = math.floor(duration * 1.5)
        end
    end

    if caster:hasStatusEffect(xi.effect.TROUBADOUR) then
        duration = math.floor(duration * 2)
    end

    -- Finish
    return duration
end

-- Main function for Enhancing Songs.
xi.spells.enhancing.useEnhancingSong = function(caster, target, spell)
    local spellId   = spell:getID()
    local paramFour = 0

    -- Get Variables from Parameters Table.
    local tier            = pTable[spellId][column.EFFECT_TIER]
    local songEffect      = pTable[spellId][column.EFFECT_MAIN]
    local subEffect       = 0
    local instrumentBoost = caster:getMod(pTable[spellId][column.MODIFIER]) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)
    local soulVoicePower  = pTable[spellId][column.SOUL_VOICE]

    -- Calculate Song Pottency, Duration and SubEffect.
    local power    = xi.spells.enhancing.calculateSongPower(caster, target, spell, spellId, tier, songEffect, instrumentBoost, soulVoicePower)
    local duration = xi.spells.enhancing.calculateSongDuration(caster, target, spell, instrumentBoost, soulVoicePower)

    -- Handle subEffect
    if songEffect == xi.effect.CAROL then
        subEffect = pTable[spellId][column.EFFECT_SUB] + (caster:getMod(xi.mod.AUGMENT_SONG_STAT) * 100)
    elseif songEffect == xi.effect.ETUDE then
        subEffect = pTable[spellId][column.EFFECT_SUB]
    else
        subEffect = caster:getMod(pTable[spellId][column.EFFECT_SUB])
    end

    -- EXCEPTION: Tier 2 Ettudes Fourth Parameter.
    if songEffect == xi.effect.ETUDE and tier == 2 then
        paramFour = 10
    end

    -- EXCEPTION: March Songs effect conversion.
    if songEffect == xi.effect.MARCH then
        power = math.floor((power / 1024) * 10000)
    end

    -- Handle Status Effects.
    if caster:hasStatusEffect(xi.effect.MARCATO) then
        caster:delStatusEffect(xi.effect.MARCATO)
    end

    -- Change message when higher effect already in place.
    if not target:addBardSong(caster, songEffect, power, paramFour, duration, caster:getID(), subEffect, tier) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return songEffect
end
