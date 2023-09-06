-----------------------------------
-- Enhancing Spell Utilities
-----------------------------------
require('scripts/globals/jobpoints')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.spells = xi.spells or {}
xi.spells.enhancing = xi.spells.enhancing or {}
-----------------------------------
-- File structure:
-- 2 Basic Functions to calculate final potency. Called by the main function.
-- 1 Basic Function to calculate final duration. Called by the main function.
-- 1 Main function, called by spell scripts.

-- Table variables.
local pTable =
{
--                                     1     2            3            4           5              6          7                 8
-- Structure:            [spellId] = { Tier, Main_Effect, Spell_Level, Base_Power, Base_Duration, Composure, Always_Overwrite, Tick_Seconds },

    -- Aquaveil
    [xi.magic.spell.AQUAVEIL     ] = { 1, xi.effect.AQUAVEIL,       1,    1,  600, true,  true,  0 },

    -- Auspice
    [xi.magic.spell.AUSPICE      ] = { 1, xi.effect.AUSPICE,       55,    0,  180, true,  false, 0 },

    -- Bar-Element
    [xi.magic.spell.BARAERO      ] = { 1, xi.effect.BARAERO,        1,    0,  480, true,  true,  0 },
    [xi.magic.spell.BARBLIZZARD  ] = { 1, xi.effect.BARBLIZZARD,    1,    0,  480, true,  true,  0 },
    [xi.magic.spell.BARFIRE      ] = { 1, xi.effect.BARFIRE,        1,    0,  480, true,  true,  0 },
    [xi.magic.spell.BARSTONE     ] = { 1, xi.effect.BARSTONE,       1,    0,  480, true,  true,  0 },
    [xi.magic.spell.BARTHUNDER   ] = { 1, xi.effect.BARTHUNDER,     1,    0,  480, true,  true,  0 },
    [xi.magic.spell.BARWATER     ] = { 1, xi.effect.BARWATER,       1,    0,  480, true,  true,  0 },
    [xi.magic.spell.BARAERA      ] = { 2, xi.effect.BARAERO,        1,    0,  480, true,  true,  0 },
    [xi.magic.spell.BARBLIZZARA  ] = { 2, xi.effect.BARBLIZZARD,    1,    0,  480, true,  true,  0 },
    [xi.magic.spell.BARFIRA      ] = { 2, xi.effect.BARFIRE,        1,    0,  480, true,  true,  0 },
    [xi.magic.spell.BARSTONRA    ] = { 2, xi.effect.BARSTONE,       1,    0,  480, true,  true,  0 },
    [xi.magic.spell.BARTHUNDRA   ] = { 2, xi.effect.BARTHUNDER,     1,    0,  480, true,  true,  0 },
    [xi.magic.spell.BARWATERA    ] = { 2, xi.effect.BARWATER,       1,    0,  480, true,  true,  0 },

    -- Bar-Effect
    [xi.magic.spell.BARAMNESIA   ] = { 1, xi.effect.BARAMNESIA,     1,   20,  480, true,  true,  0 },
    [xi.magic.spell.BARBLIND     ] = { 1, xi.effect.BARBLIND,       1,   20,  480, true,  true,  0 },
    [xi.magic.spell.BARPARALYZE  ] = { 1, xi.effect.BARPARALYZE,    1,   20,  480, true,  true,  0 },
    [xi.magic.spell.BARPETRIFY   ] = { 1, xi.effect.BARPETRIFY,     1,   20,  480, true,  true,  0 },
    [xi.magic.spell.BARPOISON    ] = { 1, xi.effect.BARPOISON,      1,   20,  480, true,  true,  0 },
    [xi.magic.spell.BARSILENCE   ] = { 1, xi.effect.BARSILENCE,     1,   20,  480, true,  true,  0 },
    [xi.magic.spell.BARSLEEP     ] = { 1, xi.effect.BARSLEEP,       1,   20,  480, true,  true,  0 },
    [xi.magic.spell.BARVIRUS     ] = { 1, xi.effect.BARVIRUS,       1,   20,  480, true,  true,  0 },
    [xi.magic.spell.BARAMNESRA   ] = { 2, xi.effect.BARAMNESIA,     1,   20,  480, true,  true,  0 },
    [xi.magic.spell.BARBLINDRA   ] = { 2, xi.effect.BARBLIND,       1,   20,  480, true,  true,  0 },
    [xi.magic.spell.BARPARALYZRA ] = { 2, xi.effect.BARPARALYZE,    1,   20,  480, true,  true,  0 },
    [xi.magic.spell.BARPETRA     ] = { 2, xi.effect.BARPETRIFY,     1,   20,  480, true,  true,  0 },
    [xi.magic.spell.BARPOISONRA  ] = { 2, xi.effect.BARPOISON,      1,   20,  480, true,  true,  0 },
    [xi.magic.spell.BARSILENCERA ] = { 2, xi.effect.BARSILENCE,     1,   20,  480, true,  true,  0 },
    [xi.magic.spell.BARSLEEPRA   ] = { 2, xi.effect.BARSLEEP,       1,   20,  480, true,  true,  0 },
    [xi.magic.spell.BARVIRA      ] = { 2, xi.effect.BARVIRUS,       1,   20,  480, true,  true,  0 },

    -- Blink
    [xi.magic.spell.BLINK        ] = { 1, xi.effect.BLINK,          1,    2,  300, true,  false, 0 },

    -- Boost-Stat
    [xi.magic.spell.BOOST_STR    ] = { 1, xi.effect.STR_BOOST,      1,    5,  300, true,  false, 0 },
    [xi.magic.spell.BOOST_DEX    ] = { 1, xi.effect.DEX_BOOST,      1,    5,  300, true,  false, 0 },
    [xi.magic.spell.BOOST_VIT    ] = { 1, xi.effect.VIT_BOOST,      1,    5,  300, true,  false, 0 },
    [xi.magic.spell.BOOST_AGI    ] = { 1, xi.effect.AGI_BOOST,      1,    5,  300, true,  false, 0 },
    [xi.magic.spell.BOOST_INT    ] = { 1, xi.effect.INT_BOOST,      1,    5,  300, true,  false, 0 },
    [xi.magic.spell.BOOST_MND    ] = { 1, xi.effect.MND_BOOST,      1,    5,  300, true,  false, 0 },
    [xi.magic.spell.BOOST_CHR    ] = { 1, xi.effect.CHR_BOOST,      1,    5,  300, true,  false, 0 },

    -- Crusade
    [xi.magic.spell.CRUSADE      ] = { 1, xi.effect.ENMITY_BOOST,  88,   30,  300, true,  false, 0 },

    -- Deodorize / Invisible / Sneak
    [xi.magic.spell.DEODORIZE    ] = { 1, xi.effect.DEODORIZE,     15,    0,  420, true,  false, 10 },
    [xi.magic.spell.INVISIBLE    ] = { 1, xi.effect.INVISIBLE,     20,    0,  420, true,  false, 10 },
    [xi.magic.spell.SNEAK        ] = { 1, xi.effect.SNEAK,         20,    0,  420, true,  false, 10 },

    -- Embrava
    [xi.magic.spell.EMBRAVA      ] = { 1, xi.effect.EMBRAVA,        5,    0,   90, true,  true,  0 },

    -- En-Spell
    [xi.magic.spell.ENAERO       ] = { 1, xi.effect.ENAERO,        20,    0,  180, true,  false, 0 },
    [xi.magic.spell.ENBLIZZARD   ] = { 1, xi.effect.ENBLIZZARD,    22,    0,  180, true,  false, 0 },
    [xi.magic.spell.ENFIRE       ] = { 1, xi.effect.ENFIRE,        24,    0,  180, true,  false, 0 },
    [xi.magic.spell.ENSTONE      ] = { 1, xi.effect.ENSTONE,       18,    0,  180, true,  false, 0 },
    [xi.magic.spell.ENTHUNDER    ] = { 1, xi.effect.ENTHUNDER,     16,    0,  180, true,  false, 0 },
    [xi.magic.spell.ENWATER      ] = { 1, xi.effect.ENWATER,       27,    0,  180, true,  false, 0 },
    [xi.magic.spell.ENAERO_II    ] = { 2, xi.effect.ENAERO_II,     54,    0,  180, true,  false, 0 },
    [xi.magic.spell.ENBLIZZARD_II] = { 2, xi.effect.ENBLIZZARD_II, 56,    0,  180, true,  false, 0 },
    [xi.magic.spell.ENFIRE_II    ] = { 2, xi.effect.ENFIRE_II,     58,    0,  180, true,  false, 0 },
    [xi.magic.spell.ENSTONE_II   ] = { 2, xi.effect.ENSTONE_II,    52,    0,  180, true,  false, 0 },
    [xi.magic.spell.ENTHUNDER_II ] = { 2, xi.effect.ENTHUNDER_II,  50,    0,  180, true,  false, 0 },
    [xi.magic.spell.ENWATER_II   ] = { 2, xi.effect.ENWATER_II,    60,    0,  180, true,  false, 0 },

    -- Flurry
    [xi.magic.spell.FLURRY       ] = { 1, xi.effect.FLURRY,        48,   15,  180, true,  false, 0 },
    [xi.magic.spell.FLURRY_II    ] = { 2, xi.effect.FLURRY_II,     96,   30,  180, true,  false, 0 },
    -- Foil
    [xi.magic.spell.FOIL         ] = { 1, xi.effect.FOIL,          58,  150,   30, true,  false, 3 },

    -- Gain-Stat
    [xi.magic.spell.GAIN_STR     ] = { 1, xi.effect.STR_BOOST,      1,    5,  300, true,  false, 0 },
    [xi.magic.spell.GAIN_DEX     ] = { 1, xi.effect.DEX_BOOST,      1,    5,  300, true,  false, 0 },
    [xi.magic.spell.GAIN_VIT     ] = { 1, xi.effect.VIT_BOOST,      1,    5,  300, true,  false, 0 },
    [xi.magic.spell.GAIN_AGI     ] = { 1, xi.effect.AGI_BOOST,      1,    5,  300, true,  false, 0 },
    [xi.magic.spell.GAIN_INT     ] = { 1, xi.effect.INT_BOOST,      1,    5,  300, true,  false, 0 },
    [xi.magic.spell.GAIN_MND     ] = { 1, xi.effect.MND_BOOST,      1,    5,  300, true,  false, 0 },
    [xi.magic.spell.GAIN_CHR     ] = { 1, xi.effect.CHR_BOOST,      1,    5,  300, true,  false, 0 },

    -- Haste
    [xi.magic.spell.HASTE        ] = { 1, xi.effect.HASTE,         48, 1465,  180, true,  false, 0 },
    [xi.magic.spell.HASTE_II     ] = { 2, xi.effect.HASTE,         96, 2998,  180, true,  false, 0 },
    [xi.magic.spell.HASTEGA      ] = { 1, xi.effect.HASTE,         48, 1494,  180, false, false, 0 },
    -- [xi.magic.spell.HASTEGA_II   ] = { 2, xi.effect.HASTE,         99, 2998,  180, false, false, 0 },

    -- Phalanx
    [xi.magic.spell.PHALANX      ] = { 1, xi.effect.PHALANX,       33,    0,  180, true,  false, 0 },
    [xi.magic.spell.PHALANX_II   ] = { 2, xi.effect.PHALANX,       75,    0,  240, true,  false, 0 },

    -- Protect / Protectra
    [xi.magic.spell.PROTECT      ] = { 1, xi.effect.PROTECT,        7,   20, 1800, false, false, 0 },
    [xi.magic.spell.PROTECT_II   ] = { 2, xi.effect.PROTECT,       27,   50, 1800, false, false, 0 },
    [xi.magic.spell.PROTECT_III  ] = { 3, xi.effect.PROTECT,       47,   90, 1800, false, false, 0 },
    [xi.magic.spell.PROTECT_IV   ] = { 4, xi.effect.PROTECT,       63,  140, 1800, false, false, 0 },
    [xi.magic.spell.PROTECT_V    ] = { 5, xi.effect.PROTECT,       76,  220, 1800, false, false, 0 },
    [xi.magic.spell.PROTECTRA    ] = { 1, xi.effect.PROTECT,        7,   20, 1800, false, false, 0 },
    [xi.magic.spell.PROTECTRA_II ] = { 2, xi.effect.PROTECT,       27,   50, 1800, false, false, 0 },
    [xi.magic.spell.PROTECTRA_III] = { 3, xi.effect.PROTECT,       47,   90, 1800, false, false, 0 },
    [xi.magic.spell.PROTECTRA_IV ] = { 4, xi.effect.PROTECT,       63,  140, 1800, false, false, 0 },
    [xi.magic.spell.PROTECTRA_V  ] = { 5, xi.effect.PROTECT,       75,  220, 1800, false, false, 0 },

    -- Refresh
    [xi.magic.spell.REFRESH      ] = { 1, xi.effect.REFRESH,       41,    3,  150, true,  true,  0 },
    [xi.magic.spell.REFRESH_II   ] = { 2, xi.effect.REFRESH,       82,    6,  150, true,  true,  0 },
    [xi.magic.spell.REFRESH_III  ] = { 3, xi.effect.REFRESH,       99,    9,  150, true,  true,  0 },

    -- Regen
    [xi.magic.spell.REGEN        ] = { 1, xi.effect.REGEN,         21,    5,   75, true,  false, 0 },
    [xi.magic.spell.REGEN_II     ] = { 2, xi.effect.REGEN,         44,   12,   60, true,  false, 0 },
    [xi.magic.spell.REGEN_III    ] = { 3, xi.effect.REGEN,         66,   20,   60, true,  false, 0 },
    [xi.magic.spell.REGEN_IV     ] = { 4, xi.effect.REGEN,         86,   30,   60, true,  false, 0 },
    [xi.magic.spell.REGEN_V      ] = { 5, xi.effect.REGEN,         99,   40,   60, true,  false, 0 },

    -- Shell / Shellra
    [xi.magic.spell.SHELL        ] = { 1, xi.effect.SHELL,         18, 1055, 1800, false, false, 0 },
    [xi.magic.spell.SHELL_II     ] = { 2, xi.effect.SHELL,         37, 1641, 1800, false, false, 0 },
    [xi.magic.spell.SHELL_III    ] = { 3, xi.effect.SHELL,         57, 2188, 1800, false, false, 0 },
    [xi.magic.spell.SHELL_IV     ] = { 4, xi.effect.SHELL,         68, 2617, 1800, false, false, 0 },
    [xi.magic.spell.SHELL_V      ] = { 5, xi.effect.SHELL,         76, 2930, 1800, false, false, 0 },
    [xi.magic.spell.SHELLRA      ] = { 1, xi.effect.SHELL,         18, 1055, 1800, false, false, 0 },
    [xi.magic.spell.SHELLRA_II   ] = { 2, xi.effect.SHELL,         37, 1641, 1800, false, false, 0 },
    [xi.magic.spell.SHELLRA_III  ] = { 3, xi.effect.SHELL,         57, 2188, 1800, false, false, 0 },
    [xi.magic.spell.SHELLRA_IV   ] = { 4, xi.effect.SHELL,         68, 2617, 1800, false, false, 0 },
    [xi.magic.spell.SHELLRA_V    ] = { 5, xi.effect.SHELL,         75, 2930, 1800, false, false, 0 },

    -- Stoneskin
    [xi.magic.spell.STONESKIN    ] = { 1, xi.effect.STONESKIN,     28,    0,  300, true,  false, 0 },

    -- -Spikes
    [xi.magic.spell.BLAZE_SPIKES ] = { 1, xi.effect.BLAZE_SPIKES,   1,    0,  180, true,  false, 0 },
    [xi.magic.spell.ICE_SPIKES   ] = { 1, xi.effect.ICE_SPIKES,     1,    0,  180, true,  false, 0 },
    [xi.magic.spell.SHOCK_SPIKES ] = { 1, xi.effect.SHOCK_SPIKES,   1,    0,  180, true,  false, 0 },

    -- -storm
    [xi.magic.spell.AURORASTORM  ] = { 1, xi.effect.AURORASTORM,   48,    2,  180, true,  true, 0 },
    [xi.magic.spell.FIRESTORM    ] = { 1, xi.effect.FIRESTORM,     44,    2,  180, true,  true, 0 },
    [xi.magic.spell.HAILSTORM    ] = { 1, xi.effect.HAILSTORM,     45,    2,  180, true,  true, 0 },
    [xi.magic.spell.RAINSTORM    ] = { 1, xi.effect.RAINSTORM,     42,    2,  180, true,  true, 0 },
    [xi.magic.spell.SANDSTORM    ] = { 1, xi.effect.SANDSTORM,     41,    2,  180, true,  true, 0 },
    [xi.magic.spell.THUNDERSTORM ] = { 1, xi.effect.THUNDERSTORM,  46,    2,  180, true,  true, 0 },
    [xi.magic.spell.VOIDSTORM    ] = { 1, xi.effect.VOIDSTORM,     47,    2,  180, true,  true, 0 },
    [xi.magic.spell.WINDSTORM    ] = { 1, xi.effect.WINDSTORM,     43,    2,  180, true,  true, 0 },

    -- Temper
    [xi.magic.spell.TEMPER       ] = { 1, xi.effect.MULTI_STRIKES, 95,    5,  180, true,  false, 0 },
    -- [xi.magic.spell.TEMPER_II    ] = { 2, 0                      , 99,    5,  180, true,  false, 0 },
}

-- Enhancing Spell Base Potency function.
xi.spells.enhancing.calculateEnhancingBasePower = function(caster, target, spell, spellId, spellEffect)
    local basePower  = pTable[spellId][4]
    local skillLevel = caster:getSkillLevel(spell:getSkillType())
    ------------------------------------------------------------
    -- Spell specific equations for potency. (Skill and stat)
    ------------------------------------------------------------

    -- Aquaveil
    if spellEffect == xi.effect.AQUAVEIL then
        if skillLevel >= 200 then -- Cutoff point is estimated. https://www.bg-wiki.com/bg/Aquaveil
            basePower = basePower + 1
        end

    -- Bar-Element
    elseif spellEffect >= xi.effect.BARFIRE and spellEffect <= xi.effect.BARWATER then
        if skillLevel > 300 then
            basePower = 25 + math.floor(skillLevel / 4) -- 150 at 500
        else
            basePower = 40 + math.floor(skillLevel / 5) -- 100 at 300
        end

        basePower = utils.clamp(basePower, 40, 150) -- Max is 150 and min is 40 at skill 0.

    -- Boost-Stat / Gain-Stat
    elseif
        spellEffect >= xi.effect.STR_BOOST and
        spellEffect <= xi.effect.CHR_BOOST
    then
        basePower = basePower + utils.clamp(math.floor((skillLevel - 300) / 10), 0, 20)

    -- Embrava
    elseif spellEffect == xi.effect.EMBRAVA then
        basePower = math.min(skillLevel, 500)

    -- En-Spells (Info from from BG-Wiki) and Auspice
    elseif
        (spellEffect >= xi.effect.ENFIRE and spellEffect <= xi.effect.ENWATER) or
        (spellEffect >= xi.effect.ENFIRE_II and spellEffect <= xi.effect.ENWATER_II) or
        spellEffect == xi.effect.AUSPICE
    then
        if skillLevel > 500 then
            basePower = math.floor(3 * (skillLevel + 50) / 25)
        elseif skillLevel > 400 then
            basePower = math.floor((skillLevel + 20) / 8)
        elseif skillLevel > 150 then
            basePower = math.floor(skillLevel / 20) + 5
        else
            basePower = math.max(math.floor(math.sqrt(skillLevel)) - 1, 0)
        end

    -- Phalanx
    elseif spellEffect == xi.effect.PHALANX then
        if skillLevel > 300 then -- Phalanx I and II over 300 skill
            basePower = utils.clamp(math.floor((skillLevel - 300.5) / 28.5) + 28, 28, 35)
        else
            if spellId == xi.magic.spell.PHALANX then -- Phalanx
                basePower = utils.clamp(math.floor(skillLevel / 10) - 2, 0, 35)
            else -- Phalanx II
                basePower = utils.clamp(math.floor(skillLevel / 25) + 16, 16, 35)
            end
        end

    -- Blaze Spikes (Info from from BG-Wiki)
    elseif spellEffect == xi.effect.BLAZE_SPIKES then
        basePower = utils.clamp(math.floor(math.floor((caster:getStat(xi.mod.INT) + 50) / 12) * (1 + caster:getMod(xi.mod.MATT) / 100)), 1, 25)

    -- Ice Spikes, Shock Spikes (Info from from BG-Wiki)
    elseif
        spellEffect == xi.effect.ICE_SPIKES or
        spellEffect == xi.effect.SHOCK_SPIKES
    then
        basePower = utils.clamp(math.floor(math.floor((caster:getStat(xi.mod.INT) + 50) / 20) * (1 + caster:getMod(xi.mod.MATT) / 100)), 1, 15)

    -- Stoneskin
    elseif spellEffect == xi.effect.STONESKIN then
        local threshold = skillLevel / 3 + caster:getStat(xi.mod.MND)

        if threshold < 80 then
            basePower = threshold
        elseif threshold <= 130 then
            basePower = 2 * threshold - 60
        elseif threshold > 130 then
            basePower = 3 * threshold - 190
        end

        basePower = utils.clamp(math.floor(basePower), 1, xi.settings.main.STONESKIN_CAP)

    -- Temper
    elseif spellEffect == xi.effect.MULTI_STRIKES then
        if skillLevel >= 360 then
            basePower = math.floor((skillLevel - 300) / 10)
        end
    end

    return basePower
end

-- Enhancing Spell Final Potency function.
xi.spells.enhancing.calculateEnhancingFinalPower = function(caster, target, spell, basePower, spellGroup, tier, spellEffect)
    local finalPower = basePower

    --------------------
    -- Enboden effect.
    --------------------
    --  Applied before other bonuses, pet buffs seem to not work.
    if
        not caster:isPet() and
        target:hasStatusEffect(xi.effect.EMBOLDEN) and
        spellGroup == xi.magic.spellGroup.WHITE
    then

        local emboldenPower = 1.5 + target:getJobPointLevel(xi.jp.EMBOLDEN_EFFECT) / 100 -- 1 point in job point category = 1%

        finalPower = math.floor(finalPower * emboldenPower)
    end

    ----------------------------------------
    -- Spell specific modifiers for potency.
    ----------------------------------------

    -- TODO: Find a way to replace big if/else chain and still make it look good.

    -- Bar-Element
    if spellEffect >= xi.effect.BARFIRE and spellEffect <= xi.effect.BARWATER then
        finalPower = finalPower + caster:getMerit(xi.merit.BAR_SPELL_EFFECT) + caster:getMod(xi.mod.BARSPELL_AMOUNT) + caster:getJobPointLevel(xi.jp.BAR_SPELL_EFFECT) * 2

    -- Bar-Status
    elseif
        spellEffect == xi.effect.BARAMNESIA or
        (spellEffect >= xi.effect.BARSLEEP and spellEffect <= xi.effect.BARVIRUS)
    then
        finalPower = finalPower + caster:getMerit(xi.merit.BAR_SPELL_EFFECT)

    -- Protect/Protectra
    elseif spellEffect == xi.effect.PROTECT then
        if target:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
            finalPower = finalPower + (tier * 2)
        end

    -- Refresh
    elseif spellEffect == xi.effect.REFRESH then
        finalPower = finalPower + caster:getMod(xi.mod.ENHANCES_REFRESH)

    -- Regen
    elseif spellEffect == xi.effect.REGEN then
        finalPower = math.ceil(finalPower * (1 + caster:getMod(xi.mod.REGEN_MULTIPLIER) / 100)) -- Bonus HP from Gear.
        finalPower = finalPower + caster:getMerit(xi.merit.REGEN_EFFECT) -- Bonus HP from Merits.
        finalPower = finalPower + caster:getMod(xi.mod.LIGHT_ARTS_REGEN) -- Bonus HP from Light Arts.
        finalPower = finalPower + caster:getMod(xi.mod.REGEN_BONUS)      -- Bonus HP from Job Point Gift.

    -- Shell/Shellra
    elseif spellEffect == xi.effect.SHELL then
        if target:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
            finalPower = finalPower + (tier * 39)
        end

    -- Stoneskin
    elseif spellEffect == xi.effect.STONESKIN then
        if caster == target then
            finalPower = utils.clamp(finalPower + caster:getMod(xi.mod.STONESKIN_BONUS_HP), 1, xi.settings.main.STONESKIN_CAP * 1.5)
        end

    -- -storm
    elseif
        spellEffect >= xi.effect.FIRESTORM and
        spellEffect <= xi.effect.VOIDSTORM
    then
        finalPower = finalPower + caster:getMerit(xi.merit.STORMSURGE) + caster:getMod(xi.mod.STORMSURGE_EFFECT)
    end

    return finalPower
end

-- Enhancing Spell Duration function.
xi.spells.enhancing.calculateEnhancingDuration = function(caster, target, spell, spellId, spellGroup, spellEffect)
    local spellLevel   = pTable[spellId][3]
    local duration     = pTable[spellId][5]
    local useComposure = pTable[spellId][6]
    local targetLevel  = target:getMainLvl()

    -- Deodorize, Invisible and Sneak have a random factor to base duration.
    if
        spellEffect == xi.effect.DEODORIZE or
        spellEffect == xi.effect.INVISIBLE or
        spellEffect == xi.effect.SNEAK
    then
        duration = duration + 60 * math.random(0, 2)
    end

    --------------------
    -- Embolden, buffs cast by pet do not work.
    --------------------
    if
        not caster:isPet() and
        target:hasStatusEffect(xi.effect.EMBOLDEN) and
        spellGroup == xi.magic.spellGroup.WHITE
    then
        local emboldenDurationModifier = 0.5 + target:getMod(xi.mod.EMBOLDEN_DURATION) / 100 -- 1 point = 1%
        duration = duration * emboldenDurationModifier
    end

    --------------------
    -- Gear mods
    --------------------
    duration = duration + duration * caster:getMod(xi.mod.ENH_MAGIC_DURATION) / 100

    ------------------------------
    -- Merits and Job Points. (Applicable to all enhancing spells. Prior to multipliers, according to bg-wiki.)
    ------------------------------
    if caster:getMainJob() == xi.job.RDM then
        duration = duration + caster:getMerit(xi.merit.ENHANCING_MAGIC_DURATION) + caster:getJobPointLevel(xi.jp.ENHANCING_DURATION)
    end

    --------------------------------------------------
    -- Spell specific modifiers for duration.
    --------------------------------------------------
    -- Regen
    if spellEffect == xi.effect.REGEN then
        duration = duration + caster:getMod(xi.mod.REGEN_DURATION)
        duration = duration + caster:getJobPointLevel(xi.jp.REGEN_DURATION) * 3

    -- Invisible
    elseif spellEffect == xi.effect.INVISIBLE then
        duration = duration + target:getMod(xi.mod.INVISIBLE_DURATION)

    -- Sneak
    elseif spellEffect == xi.effect.SNEAK then
        duration = duration + target:getMod(xi.mod.SNEAK_DURATION)
    end

    --------------------
    -- Status Effects
    --------------------
    -- Composure
    if
        useComposure and
        caster:hasStatusEffect(xi.effect.COMPOSURE) and
        caster:getID() == target:getID()
    then
        duration = duration * 3
    end

    -- Perpetuance (Doesnt affect spikes and other Black magic enhancements)
    if
        caster:hasStatusEffect(xi.effect.PERPETUANCE) and
        spellGroup == xi.magic.spellGroup.WHITE
    then
        duration  = duration * 2
    end

    ------------------------------
    -- Level penalty to duration.
    ------------------------------
    if targetLevel < spellLevel then
        duration = duration * targetLevel / spellLevel
    end

    return duration
end

-- Main function for Enhancing Spells.
xi.spells.enhancing.useEnhancingSpell = function(caster, target, spell)
    local spellId           = spell:getID()
    local spellGroup        = spell:getSpellGroup()
    local magicDefenseBonus = 0

    -- Get Variables from Parameters Table.
    local tier            = pTable[spellId][1]
    local spellEffect     = pTable[spellId][2]
    local alwaysOverwrite = pTable[spellId][7]
    local tickTime        = pTable[spellId][8]

    ------------------------------------------------------------
    -- Handle exceptions and weird behaviour here, before calculating anything.
    ------------------------------------------------------------
    -- Bar-Element (They use addStatusEffect argument 6. Bar-Status current implementation doesn't.)
    if spellEffect >= xi.effect.BARFIRE and spellEffect <= xi.effect.BARWATER then
        magicDefenseBonus = caster:getMerit(xi.merit.BAR_SPELL_EFFECT) + caster:getMod(xi.mod.BARSPELL_MDEF_BONUS)

    -- Embrava
    elseif spellEffect == xi.effect.EMBRAVA then
        -- If Tabula Rasa wears before spell goes off, no Embrava for you!
        if not caster:hasStatusEffect(xi.effect.TABULA_RASA) then
            spell:setMsg(xi.msg.basic.MAGIC_CANNOT_CAST)
            return 0
        end

    -- Refresh
    elseif spellEffect == xi.effect.REFRESH then
        if
            target:hasStatusEffect(xi.effect.SUBLIMATION_ACTIVATED) or
            target:hasStatusEffect(xi.effect.SUBLIMATION_COMPLETE)
        then
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
            return 0
        end

    -- Boost-Stat / Gain-Stat
    elseif
        spellEffect >= xi.effect.STR_BOOST and
        spellEffect <= xi.effect.CHR_BOOST
    then
        -- Only one Boost Effect can be active at once, so if the player has any we have to cancel & overwrite
        local effectOverwrite =
        {
            xi.effect.STR_BOOST,
            xi.effect.DEX_BOOST,
            xi.effect.VIT_BOOST,
            xi.effect.AGI_BOOST,
            xi.effect.INT_BOOST,
            xi.effect.MND_BOOST,
            xi.effect.CHR_BOOST
        }

        for i, effectValue in ipairs(effectOverwrite) do
            if target:hasStatusEffect(effectValue) then
                target:delStatusEffect(effectValue)
            end
        end

    -- -storm spells
    elseif
        spellEffect >= xi.effect.FIRESTORM and
        spellEffect <= xi.effect.VOIDSTORM
    then
        -- Only one storm effect can be active at once, so if the player has any we have to cancel & overwrite
        local effectOverwrite =
        {
            xi.effect.FIRESTORM,
            xi.effect.SANDSTORM,
            xi.effect.RAINSTORM,
            xi.effect.WINDSTORM,
            xi.effect.HAILSTORM,
            xi.effect.THUNDERSTORM,
            xi.effect.AURORASTORM,
            xi.effect.VOIDSTORM
        }

        for i, effectValue in ipairs(effectOverwrite) do
            if target:hasStatusEffect(effectValue) then
                target:delStatusEffect(effectValue)
            end
        end
    end

    --------------------------------------------------
    -- Calculate Spell Pottency and Duration.
    --------------------------------------------------
    local basePower  = xi.spells.enhancing.calculateEnhancingBasePower(caster, target, spell, spellId, spellEffect)
    local finalPower = xi.spells.enhancing.calculateEnhancingFinalPower(caster, target, spell, basePower, spellGroup, tier, spellEffect)
    local duration   = xi.spells.enhancing.calculateEnhancingDuration(caster, target, spell, spellId, spellGroup, spellEffect)

    ------------------------------
    -- Handle Status Effects, Embolden buffs can only be applied by player, so do not remove embolden..
    ------------------------------
    if
        not caster:isPet() and
        target:hasStatusEffect(xi.effect.EMBOLDEN) and
        spellGroup == xi.magic.spellGroup.WHITE
    then
        target:delStatusEffectSilent(xi.effect.EMBOLDEN)
    end

    ------------------------------------------------------------
    -- Change message when higher effect or "Always overwrite".
    ------------------------------------------------------------
    if alwaysOverwrite then
        target:delStatusEffect(spellEffect)
        target:addStatusEffect(spellEffect, finalPower, tickTime, duration, 0, magicDefenseBonus, tier)
    else
        if target:addStatusEffect(spellEffect, finalPower, tickTime, duration, 0, magicDefenseBonus, tier) then
            spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- No effect.
        end
    end

    return spellEffect
end
