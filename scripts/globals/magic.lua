require("scripts/globals/jobpoints")
require("scripts/globals/magicburst")
require("scripts/globals/utils")
-----------------------------------
xi = xi or {}
xi.magic = xi.magic or {}

-----------------------------------
-- Day to Element Mapping
-----------------------------------

xi.magic.dayElement =
{
    [xi.day.FIRESDAY]     = xi.magic.element.FIRE,
    [xi.day.ICEDAY]       = xi.magic.element.ICE,
    [xi.day.WINDSDAY]     = xi.magic.element.WIND,
    [xi.day.EARTHSDAY]    = xi.magic.element.EARTH,
    [xi.day.LIGHTNINGDAY] = xi.magic.element.THUNDER,
    [xi.day.WATERSDAY]    = xi.magic.element.WATER,
    [xi.day.LIGHTSDAY]    = xi.magic.element.LIGHT,
    [xi.day.DARKSDAY]     = xi.magic.element.DARK,
}

-----------------------------------
-- Tables by element
-----------------------------------

xi.magic.dayWeak =
{
    xi.magic.dayElement[xi.day.WATERSDAY],
    xi.magic.dayElement[xi.day.FIRESDAY],
    xi.magic.dayElement[xi.day.ICEDAY],
    xi.magic.dayElement[xi.day.WINDSDAY],
    xi.magic.dayElement[xi.day.EARTHSDAY],
    xi.magic.dayElement[xi.day.LIGHTNINGDAY],
    xi.magic.dayElement[xi.day.DARKSDAY],
    xi.magic.dayElement[xi.day.LIGHTSDAY]
}

xi.magic.singleWeatherStrong   = { xi.weather.HOT_SPELL,         xi.weather.SNOW,             xi.weather.WIND,               xi.weather.DUST_STORM,         xi.weather.THUNDER,                xi.weather.RAIN,                xi.weather.AURORAS,         xi.weather.GLOOM          }
xi.magic.doubleWeatherStrong   = { xi.weather.HEAT_WAVE,         xi.weather.BLIZZARDS,        xi.weather.GALES,              xi.weather.SAND_STORM,         xi.weather.THUNDERSTORMS,          xi.weather.SQUALL,              xi.weather.STELLAR_GLARE,   xi.weather.DARKNESS       }
xi.magic.elementalObi          = { xi.mod.FORCE_FIRE_DWBONUS,    xi.mod.FORCE_ICE_DWBONUS,    xi.mod.FORCE_WIND_DWBONUS,     xi.mod.FORCE_EARTH_DWBONUS,    xi.mod.FORCE_LIGHTNING_DWBONUS,    xi.mod.FORCE_WATER_DWBONUS,     xi.mod.FORCE_LIGHT_DWBONUS, xi.mod.FORCE_DARK_DWBONUS }
local spellAcc                 = { xi.mod.FIREACC,               xi.mod.ICEACC,               xi.mod.WINDACC,                xi.mod.EARTHACC,               xi.mod.THUNDERACC,                 xi.mod.WATERACC,                xi.mod.LIGHTACC,            xi.mod.DARKACC            }
local strongAffinityDmg        = { xi.mod.FIRE_AFFINITY_DMG,     xi.mod.ICE_AFFINITY_DMG,     xi.mod.WIND_AFFINITY_DMG,      xi.mod.EARTH_AFFINITY_DMG,     xi.mod.THUNDER_AFFINITY_DMG,       xi.mod.WATER_AFFINITY_DMG,      xi.mod.LIGHT_AFFINITY_DMG,  xi.mod.DARK_AFFINITY_DMG  }
local strongAffinityAcc        = { xi.mod.FIRE_AFFINITY_ACC,     xi.mod.ICE_AFFINITY_ACC,     xi.mod.WIND_AFFINITY_ACC,      xi.mod.EARTH_AFFINITY_ACC,     xi.mod.THUNDER_AFFINITY_ACC,       xi.mod.WATER_AFFINITY_ACC,      xi.mod.LIGHT_AFFINITY_ACC,  xi.mod.DARK_AFFINITY_ACC  }
xi.magic.resistMod             = { xi.mod.FIRE_MEVA,             xi.mod.ICE_MEVA,             xi.mod.WIND_MEVA,              xi.mod.EARTH_MEVA,             xi.mod.THUNDER_MEVA,               xi.mod.WATER_MEVA,              xi.mod.LIGHT_MEVA,          xi.mod.DARK_MEVA          }
xi.magic.specificDmgTakenMod   = { xi.mod.FIRE_SDT,              xi.mod.ICE_SDT,              xi.mod.WIND_SDT,               xi.mod.EARTH_SDT,              xi.mod.THUNDER_SDT,                xi.mod.WATER_SDT,               xi.mod.LIGHT_SDT,           xi.mod.DARK_SDT           }
xi.magic.eleEvaMult            = { xi.mod.FIRE_EEM,              xi.mod.ICE_EEM,              xi.mod.WIND_EEM,               xi.mod.EARTH_EEM,              xi.mod.THUNDER_EEM,                xi.mod.WATER_EEM,               xi.mod.LIGHT_EEM,           xi.mod.DARK_EEM           }
xi.magic.absorbMod             = { xi.mod.FIRE_ABSORB,           xi.mod.ICE_ABSORB,           xi.mod.WIND_ABSORB,            xi.mod.EARTH_ABSORB,           xi.mod.LTNG_ABSORB,                xi.mod.WATER_ABSORB,            xi.mod.LIGHT_ABSORB,        xi.mod.DARK_ABSORB        }
local nullMod                  = { xi.mod.FIRE_NULL,             xi.mod.ICE_NULL,             xi.mod.WIND_NULL,              xi.mod.EARTH_NULL,             xi.mod.LTNG_NULL,                  xi.mod.WATER_NULL,              xi.mod.LIGHT_NULL,          xi.mod.DARK_NULL          }
local blmMerit                 = { xi.merit.FIRE_MAGIC_POTENCY,  xi.merit.ICE_MAGIC_POTENCY,  xi.merit.WIND_MAGIC_POTENCY,   xi.merit.EARTH_MAGIC_POTENCY,  xi.merit.LIGHTNING_MAGIC_POTENCY,  xi.merit.WATER_MAGIC_POTENCY                                                          }
local rdmMerit                 = { xi.merit.FIRE_MAGIC_ACCURACY, xi.merit.ICE_MAGIC_ACCURACY, xi.merit.WIND_MAGIC_ACCURACY,  xi.merit.EARTH_MAGIC_ACCURACY, xi.merit.LIGHTNING_MAGIC_ACCURACY, xi.merit.WATER_MAGIC_ACCURACY                                                         }
xi.magic.barSpell              = { xi.effect.BARFIRE,            xi.effect.BARBLIZZARD,       xi.effect.BARAERO,             xi.effect.BARSTONE,            xi.effect.BARTHUNDER,              xi.effect.BARWATER                                                                    }
xi.magic.singleWeatherWeak     = { xi.weather.RAIN,              xi.weather.HOT_SPELL,        xi.weather.SNOW,               xi.weather.WIND,               xi.weather.DUST_STORM,             xi.weather.THUNDER,             xi.weather.GLOOM,           xi.weather.AURORAS        }
xi.magic.doubleWeatherWeak     = { xi.weather.SQUALL,            xi.weather.HEAT_WAVE,        xi.weather.BLIZZARDS,          xi.weather.GALES,              xi.weather.SAND_STORM,             xi.weather.THUNDERSTORMS,       xi.weather.DARKNESS,        xi.weather.STELLAR_GLARE  }
xi.magic.eemStatus             = { xi.effect.FIRE_EEM_MOD,       xi.effect.ICE_EEM_MOD,       xi.effect.WIND_EEM_MOD,        xi.effect.EARTH_EEM_MOD,       xi.effect.THUNDER_EEM_MOD,         xi.effect.WATER_EEM_MOD,        xi.effect.LIGHT_EEM_MOD,    xi.effect.DARK_EEM_MOD    }

xi.magic.mevaDownException     = { xi.effect.SLOW, xi.effect.PARALYSIS, xi.effect.SILENCE, xi.effect.ADDLE, xi.effect.BLINDNESS, xi.effect.WEIGHT, xi.effect.BIND, xi.effect.POISON, xi.effect.PETRIFICATION, xi.effect.SLEEP_I, xi.effect.SLEEP_II, xi.effect.LULLABY               }
xi.magic.eemTiers =
{
    { eem = 1.50, mult = 0.95,    tier = -18, baseTier = true  },
    { eem = 1.30, mult = 0.96019, tier = -17, baseTier = false },
    { eem = 1.30, mult = 0.96019, tier = -16, baseTier = false },
    { eem = 1.30, mult = 0.96019, tier = -15, baseTier = false },
    { eem = 1.30, mult = 0.96019, tier = -14, baseTier = false },
    { eem = 1.30, mult = 0.96019, tier = -13, baseTier = false },
    { eem = 1.30, mult = 0.96019, tier = -12, baseTier = true  },
    { eem = 1.15, mult = 0.98,    tier = -11, baseTier = false },
    { eem = 1.15, mult = 0.98,    tier = -10, baseTier = false },
    { eem = 1.15, mult = 0.98,    tier = -9,  baseTier = false },
    { eem = 1.15, mult = 0.98,    tier = -8,  baseTier = false },
    { eem = 1.15, mult = 0.98,    tier = -7,  baseTier = false },
    { eem = 1.00, mult = 1,       tier = -6,  baseTier = true  },
    { eem = 1.00, mult = 1,       tier = -5,  baseTier = false },
    { eem = 1.00, mult = 1,       tier = -4,  baseTier = false },
    { eem = 1.00, mult = 1,       tier = -3,  baseTier = false },
    { eem = 1.00, mult = 1,       tier = -2,  baseTier = false },
    { eem = 1.00, mult = 1,       tier = -1,  baseTier = false },
    { eem = 1.00, mult = 1,       tier = 0,   baseTier = true  },
    { eem = 0.85, mult = 1.023,   tier = 1,   baseTier = true  },
    { eem = 0.70, mult = 1.049,   tier = 2,   baseTier = true  },
    { eem = 0.60, mult = 1.0905,  tier = 3,   baseTier = true  },
    { eem = 0.50, mult = 1.126,   tier = 4,   baseTier = true  },
    { eem = 0.40, mult = 1.2075,  tier = 5,   baseTier = true  },
    { eem = 0.30, mult = 1.3475,  tier = 6,   baseTier = true  },
    { eem = 0.25, mult = 1.70065, tier = 7,   baseTier = true  },
    { eem = 0.20, mult = 2.141,   tier = 8,   baseTier = true  },
    { eem = 0.15, mult = 2.65,    tier = 9,   baseTier = true  },
    { eem = 0.10, mult = 2.96,    tier = 10,  baseTier = true  },
    { eem = 0.05, mult = 3.52,    tier = 11,  baseTier = true  }
}

xi.magic.effectEva =
{
    [xi.effect.SLEEP_I] = xi.mod.SLEEP_MEVA,
    [xi.effect.SLEEP_II] = xi.mod.SLEEP_MEVA,
    [xi.effect.POISON] = xi.mod.POISON_MEVA,
    [xi.effect.PARALYSIS] = xi.mod.PARALYZE_MEVA,
    [xi.effect.BLINDNESS] = xi.mod.BLIND_MEVA,
    [xi.effect.SILENCE] = xi.mod.SILENCE_MEVA,
    [xi.effect.PLAGUE] = xi.mod.VIRUS_MEVA,
    [xi.effect.PETRIFICATION] = xi.effect.PETRIFY_MEVA
}

-- USED FOR DAMAGING MAGICAL SPELLS (Stages 1 and 2 in Calculating Magic Damage on wiki)
--Calculates magic damage using the standard magic damage calc.
--Does NOT handle resistance.
-- Inputs:
-- dmg - The base damage of the spell
-- multiplier - The INT multiplier of the spell
-- skilltype - The skill ID of the spell.
-- atttype - The attribute type (usually xi.mod.INT , except for things like Banish which is xi.mod.MND)
-- hasMultipleTargetReduction - true ifdamage is reduced on AoE. False otherwise (e.g. Charged Whisker vs -ga3 spells)
--
-- Output:
-- The total damage, before resistance and before equipment (so no HQ staff bonus worked out here).
local softCap = 60 --guesstimated
local hardCap = 120 --guesstimated

-----------------------------------
-- Returns the staff bonus for the caster and spell.
-----------------------------------
-- affinities that strengthen/weaken the index element
local function AffinityBonusDmg(caster, ele)
    local affinity = 0
    local bonus = 0
    if strongAffinityDmg[ele] ~= nil then
        affinity = caster:getMod(strongAffinityDmg[ele])
        bonus = 1.00 + affinity * 0.05 -- 5% per level of affinity
    end

    return bonus
end

local function AffinityBonusAcc(caster, ele)
    local affinity = caster:getMod(strongAffinityAcc[ele])
    local bonus = 0 + affinity * 10 -- 10 acc per level of affinity
    return bonus
end

-- Returns the bonus magic accuracy for any spell
local function getSpellBonusAcc(caster, target, spell, params)
    local magicAccBonus  = 0
    local castersWeather = caster:getWeather()
    local skill = xi.skill.NONE
    if spell ~= nil then
        skill = spell:getSkillType()
    end

    local spellGroup = spell:getSpellGroup()
    local element = spell:getElement()
    local casterJob = caster:getMainJob()

    if
        caster:hasStatusEffect(xi.effect.ALTRUISM) and
        spellGroup == xi.magic.spellGroup.WHITE
    then
        magicAccBonus = magicAccBonus + caster:getStatusEffect(xi.effect.ALTRUISM):getPower()
    end

    if
        caster:hasStatusEffect(xi.effect.FOCALIZATION) and
        spellGroup == xi.magic.spellGroup.BLACK
    then
        magicAccBonus = magicAccBonus + caster:getStatusEffect(xi.effect.FOCALIZATION):getPower()
    end

    -- Apply Divine Emblem to Flash
    if
        caster:hasStatusEffect(xi.effect.DIVINE_EMBLEM) and
        skill == xi.skill.DIVINE_MAGIC
    then
        magicAccBonus = magicAccBonus + 100 -- TODO: Confirm this with retail
    end

    -- Apply Dark Seal to Dark Magic
    -- http://wiki.ffo.jp/html/3247.html
    -- Similar to Elemental Seal but only for Dark Magic
    if
        caster:hasStatusEffect(xi.effect.DARK_SEAL) and
        skill == xi.skill.DARK_MAGIC
    then
        magicAccBonus = magicAccBonus + 256
    end

    -- Add acc for klimaform
    if element > 0 then
        if
            caster:hasStatusEffect(xi.effect.KLIMAFORM) and
            (
                castersWeather == xi.magic.singleWeatherStrong[element] or
                castersWeather == xi.magic.doubleWeatherStrong[element]
            )
        then
            magicAccBonus = magicAccBonus + 15
        end
    end

    switch(casterJob): caseof
    {
        [xi.job.WHM] = function()
            magicAccBonus = magicAccBonus + caster:getJobPointLevel(xi.jp.WHM_MAGIC_ACC_BONUS)
        end,

        [xi.job.BLM] = function()
            -- Add MACC for BLM Elemental Magic Merits
            if skill == xi.skill.ELEMENTAL_MAGIC then
                magicAccBonus = magicAccBonus + caster:getMerit(xi.merit.ELEMENTAL_MAGIC_ACCURACY)
            end

            -- BLM Job Point: MACC Bonus +1
            magicAccBonus = magicAccBonus + caster:getJobPointLevel(xi.jp.BLM_MAGIC_ACC_BONUS)
        end,

        [xi.job.DRK] = function()
            -- Add MACC for Dark Seal
            if
                skill == xi.skill.DARK_MAGIC and
                caster:hasStatusEffect(xi.effect.DARK_SEAL)
            then
                magicAccBonus = magicAccBonus + 256
            end
        end,
    }

    if casterJob == xi.job.DRK then
        -- Add MACC for Dark Seal
        if
            skill == xi.skill.DARK_MAGIC and
            caster:hasStatusEffect(xi.effect.DARK_SEAL)
        then
            magicAccBonus = magicAccBonus + 100
        end
    end

    if caster:hasStatusEffect(xi.effect.ELEMENTAL_SEAL) then
        magicAccBonus = magicAccBonus + 256
    end

    switch(casterJob): caseof
    {
        [xi.job.RDM] = function()
            -- Add MACC for RDM group 1 merits
            if
                element >= xi.magic.ele.FIRE and
                element <= xi.magic.ele.WATER
            then
                magicAccBonus = magicAccBonus + caster:getMerit(rdmMerit[element])
            end

            -- RDM Job Point: During saboteur, Enfeebling MACC +2
            if
                skill == xi.skill.ENFEEBLING_MAGIC and
                caster:hasStatusEffect(xi.effect.SABOTEUR)
            then
                local jpValue = caster:getJobPointLevel(xi.jp.SABOTEUR_EFFECT)
                magicAccBonus = magicAccBonus + (jpValue * 2)
            end

            -- RDM Job Point: Magic Accuracy Bonus, All MACC + 1
            magicAccBonus = magicAccBonus + caster:getJobPointLevel(xi.jp.RDM_MAGIC_ACC_BONUS)
        end,

        [xi.job.NIN] = function()
            -- NIN Job Point: Ninjitsu Accuracy Bonus
            if skill == xi.skill.NINJUTSU then
                magicAccBonus = magicAccBonus + caster:getJobPointLevel(xi.jp.NINJITSU_ACC_BONUS)
            end
        end,

        [xi.job.BLU] = function()
            -- BLU MACC merits - nuke acc is handled in bluemagic.lua
            if skill == xi.skill.BLUE_MAGIC then
                magicAccBonus = magicAccBonus + caster:getMerit(xi.merit.MAGICAL_ACCURACY)
            end
        end,

        [xi.job.SCH] = function()
            if
                (spellGroup == xi.magic.spellGroup.WHITE and caster:hasStatusEffect(xi.effect.PARSIMONY)) or
                (spellGroup == xi.magic.spellGroup.BLACK and caster:hasStatusEffect(xi.effect.PENURY))
            then
                local jpValue = caster:getJobPointLevel(xi.jp.STRATEGEM_EFFECT_I)

                magicAccBonus = magicAccBonus + jpValue
            end
        end,
    }

    return magicAccBonus
end

local handleMevaException = function(target, effect, debuffEffect, element, resMod)
    local debuff = target:getStatusEffect(debuffEffect)
    for _, effectFound in pairs(xi.magic.mevaDownException) do
        if
            effect == effectFound and
            debuff:getSubPower() == xi.magic.resistMod[element]
        then
            return resMod + debuff:getPower()
        end
    end

    return resMod
end

xi.magic.calculateMagicHitRate = function(magicacc, magiceva, target, element, skillchainCount, skill, caster, isDamageSpell, hybridHit, dLvl)
    local p = 0
    local eemTier = 0
    local resBuild = 0
    local mevaMult = 1
    local eemBonus = 0

    if target and element and element ~= xi.magic.ele.NONE and target:isMob() then
        eemTier = xi.magic.calculateEEMTier(target, element, skillchainCount)
        resBuild = utils.ternary(target:isNM() and isDamageSpell, xi.magic.tryBuildResistance(target, xi.magic.resistMod[element], false, caster), 0)
        mevaMult = xi.magic.calculateMEVAMult(utils.clamp(eemTier + resBuild, -18, 11))
        eemBonus = (target:getMod(xi.mod.MEVA) * mevaMult) - target:getMod(xi.mod.MEVA)
    end

    local magicAccDiff = magicacc - math.floor(magiceva + eemBonus + 0.5) -- Rounds to the nearest integer. LuaJIT does not have a math.round so this is a workaround.

    if magicAccDiff < 0 and hybridHit then
        p = utils.clamp(((75 + math.floor(magicAccDiff / 2)) - (4 * dLvl)), 5, 95)
    elseif magicAccDiff < 0 then
        p = utils.clamp(((50 + math.floor(magicAccDiff / 2))), 5, 95)
    else
        p = utils.clamp(((50 + magicAccDiff)), 5, 95)
    end

    -- If the eemTier is 0.1 (Tier 10) then the magic hit rate is floored to 5%
    if eemTier == 10 then
        p = 5
    end

    return p
end

local function isHelixSpell(spell)
    --Dark Arts will further increase Helix duration, but testing is ongoing.

    local id = spell:getID()
    if id >= 278 and id <= 285 then
        return true
    end

    return false
end

local function calculateMagicBurst(caster, spell, target, params)
    local burst = 1.0
    local skillchainburst = 1.0
    local modburst = 1.0

    if
        spell:getSpellGroup() == 3 and
        not (caster:hasStatusEffect(xi.effect.BURST_AFFINITY) or caster:hasStatusEffect(xi.effect.AZURE_LORE))
    then
        return burst
    end

    -- Obtain first multiplier from gear, atma and job traits
    modburst = modburst + (caster:getMod(xi.mod.MAG_BURST_BONUS) / 100) + params.AMIIburstBonus

    if caster:isBehind(target) and caster:hasStatusEffect(xi.effect.INNIN) then
        modburst = modburst + (caster:getMerit(xi.merit.INNIN_EFFECT) / 100)
    end

    -- BLM Job Point: Magic Burst Damage
    modburst = modburst + (caster:getJobPointLevel(xi.jp.MAGIC_BURST_DMG_BONUS) / 100)

    -- Cap bonuses from first multiplier at 40% or 1.4
    if modburst > 1.4 then
        modburst = 1.4
    end

    -- Obtain second multiplier from skillchain
    -- Starts at 35% damage bonus, increases by 10% for every additional weaponskill in the chain
    local skillchainTier, skillchainCount = xi.magic.FormMagicBurst(spell:getElement(), target)

    if skillchainTier > 0 then
        if skillchainCount == 1 then -- two weaponskills
            skillchainburst = 1.35
        elseif skillchainCount == 2 then -- three weaponskills
            skillchainburst = 1.45
        elseif skillchainCount == 3 then -- four weaponskills
            skillchainburst = 1.55
        elseif skillchainCount == 4 then -- five weaponskills
            skillchainburst = 1.65
        elseif skillchainCount == 5 then -- six weaponskills
            skillchainburst = 1.75
        else
            -- Something strange is going on if this occurs.
            skillchainburst = 1.0
        end
    end

    -- Multiply
    if skillchainburst > 1 then
        burst = burst * modburst * skillchainburst
    end

    return burst
end

xi.magic.calculateMagicDamage = function(caster, target, spell, params)
    local dINT = caster:getStat(params.attribute) - target:getStat(params.attribute)
    local dmg = params.dmg

    if dINT <= 0 then --if dINT penalises, it's always M=1
        dmg = dmg + dINT
        if dmg <= 0 then --dINT penalty cannot result in negative damage (target absorption)
            return 0
        end
    elseif dINT > 0 and dINT <= softCap then --The standard calc, most spells hit this
        dmg = dmg + (dINT * params.multiplier)
    elseif dINT > 0 and dINT > softCap and dINT < hardCap then --After softCap, INT is only half effective
        dmg = dmg + softCap * params.multiplier + ((dINT - softCap) * params.multiplier) / 2
    elseif dINT > 0 and dINT > softCap and dINT >= hardCap then --After hardCap, INT has no xi.effect.
        dmg = dmg + hardCap * params.multiplier
    end

    if params.skillType == xi.skill.DIVINE_MAGIC and target:isUndead() then
        -- 150% bonus damage
        dmg = dmg * 1.5
    end

    return dmg
end

xi.magic.doEnspell = function(caster, target, spell, effect)
    -- Calculate Bonus duration
    local baseDuration = 0
    if caster:getEquipID(xi.slot.MAIN) == xi.items.BUZZARD_TUCK then
        baseDuration = 210
    else
        baseDuration = 180
    end

    local duration = xi.magic.calculateDuration(baseDuration, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    --calculate potency
    local magicskill = caster:getSkillLevel(xi.skill.ENHANCING_MAGIC)

    -- Add effect bonuses from equipment
    local potencybonus = 0
    if caster:getEquipID(xi.slot.MAIN) == xi.items.BUZZARD_TUCK then
        potencybonus = 2 + potencybonus
    elseif
        caster:getEquipID(xi.slot.EAR1) == xi.items.LYCOPODIUM_EARRING or
        caster:getEquipID(xi.slot.EAR2) == xi.items.LYCOPODIUM_EARRING
    then
        potencybonus = 2 + potencybonus
    elseif
        caster:getEquipID(xi.slot.EAR1) == xi.items.HOLLOW_EARRING or
        caster:getEquipID(xi.slot.EAR2) == xi.items.HOLLOW_EARRING
    then
        potencybonus = 3 + potencybonus
    elseif
        caster:getHPP() <= 75 and
        caster:getTP() <= 100 and
        (caster:getEquipID(xi.slot.RING1) == xi.items.FENCERS_RING or
        caster:getEquipID(xi.slot.RING2) == xi.items.FENCERS_RING)
    then
        potencybonus = 5 + potencybonus
    elseif caster:getEquipID(xi.slot.MAIN) == xi.items.ENHANCING_SWORD then
        potencybonus = 5 + potencybonus
    end

    -- Potency with Effect Bonus
    local potency = 0
    if
        caster:getWeaponSkillType(xi.slot.MAIN) == xi.skill.SWORD or
        caster:getWeaponSkillType(xi.slot.SUB) == xi.skill.SWORD
    then
        if magicskill <= 200 then
            potency = 3 + potencybonus + math.floor(6 * magicskill / 100)
        elseif magicskill > 200 then
            potency = 5 + potencybonus + math.floor(5 * magicskill / 100)
        end
    -- Potency without Effect Bonus
    else
        if magicskill <= 200 then
            potency = 3 + math.floor(6 * magicskill / 100)
        elseif magicskill > 200 then
            potency = 5 + math.floor(5 * magicskill / 100)
        end
    end

    if target:addStatusEffect(effect, potency, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end
end

-----------------------------------
--   xi.magic.getCurePower returns the caster's cure power
--   xi.magic.getCureFinal returns the final cure amount
--   Source: http://members.shaw.ca/pizza_steve/cure/Cure_Calculator.html
-----------------------------------
xi.magic.getCurePower = function(caster, isBlueMagic)
    local mnd = caster:getStat(xi.mod.MND)
    local vit = caster:getStat(xi.mod.VIT)
    local skill = caster:getSkillLevel(xi.skill.HEALING_MAGIC)
    local power = math.floor(mnd / 2) + math.floor(vit / 4) + skill
    return power
end

xi.magic.getCurePowerOld = function(caster)
    local mnd = caster:getStat(xi.mod.MND)
    local vit = caster:getStat(xi.mod.VIT)
    local skill = caster:getSkillLevel(xi.skill.HEALING_MAGIC) -- it's healing magic skill for the BLU cures as well
    local power = (3 * mnd) + vit + (3 * math.floor(skill / 5))
    return power
end

xi.magic.getBaseCure = function(power, divisor, constant, basepower)
    return ((power - basepower) / divisor) + constant
end

xi.magic.getBaseCureOld = function(power, divisor, constant)
    return (power / 2) / divisor + constant
end

xi.magic.getCureFinal = function(caster, spell, basecure, minCure, isBlueMagic)
    if basecure < minCure then
        basecure = minCure
    end

    local curePot = math.min(caster:getMod(xi.mod.CURE_POTENCY), 50) / 100 -- caps at 50%
    local curePotII = math.min(caster:getMod(xi.mod.CURE_POTENCY_II), 30) / 100 -- caps at 30%
    local potency = 1 + curePot + curePotII

    local dSeal = 1
    if caster:hasStatusEffect(xi.effect.DIVINE_SEAL) then
        dSeal = 2
    end

    local rapture = 1
    if not isBlueMagic then --rapture doesn't affect BLU cures as they're not white magic
        if caster:hasStatusEffect(xi.effect.RAPTURE) then
            rapture = 1.5 + caster:getMod(xi.mod.RAPTURE_AMOUNT) / 100
            caster:delStatusEffectSilent(xi.effect.RAPTURE)
        end
    end

    local dayWeatherBonus = 1
    local ele = spell:getElement()

    local castersWeather = caster:getWeather()

    if castersWeather == xi.magic.singleWeatherStrong[ele] then
        if caster:getMod(xi.mod.IRIDESCENCE) >= 1 then
            if math.random() < 0.33 or caster:getMod(xi.magic.elementalObi[ele]) >= 1 then
                dayWeatherBonus = dayWeatherBonus + 0.10
            end
        end

        if math.random() < 0.33 or caster:getMod(xi.magic.elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif castersWeather == xi.magic.singleWeatherWeak[ele] then
        if math.random() < 0.33 or caster:getMod(xi.magic.elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    elseif castersWeather == xi.magic.doubleWeatherStrong[ele] then
        if caster:getMod(xi.mod.IRIDESCENCE) >= 1 then
            if math.random() < 0.33 or caster:getMod(xi.magic.elementalObi[ele]) >= 1 then
                dayWeatherBonus = dayWeatherBonus + 0.10
            end
        end

        if math.random() < 0.33 or caster:getMod(xi.magic.elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.25
        end
    elseif castersWeather == xi.magic.doubleWeatherWeak[ele] then
        if math.random() < 0.33 or caster:getMod(xi.magic.elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus - 0.25
        end
    end

    local dayElement = VanadielDayElement()
    if dayElement == ele then
        if math.random() < 0.33 or caster:getMod(xi.magic.elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif dayElement == xi.magic.elementDescendant[ele] then
        if math.random() < 0.33 or caster:getMod(xi.magic.elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    end

    if dayWeatherBonus > 1.4 then
        dayWeatherBonus = 1.4
    end

    local final = math.floor(math.floor(math.floor(math.floor(basecure) * potency) * dayWeatherBonus) * rapture) * dSeal
    return final
end

xi.magic.isValidHealTarget = function(caster, target)
    if
        target:hasStatusEffect(xi.effect.ALL_MISS) and
        target:getStatusEffect(xi.effect.ALL_MISS):getPower() > 1
    then
        return false
    else
        return target:getAllegiance() == caster:getAllegiance() and
                (target:getObjType() == xi.objType.PC or
                target:getObjType() == xi.objType.MOB or
                target:getObjType() == xi.objType.TRUST or
                target:getObjType() == xi.objType.FELLOW)
    end
end

-- USED FOR DAMAGING MAGICAL SPELLS. Stage 3 of Calculating Magic Damage on wiki
-- Reduces damage ifit resists.
--
-- Output:
-- The factor to multiply down damage (1/2 1/4 1/8 1/16) - In this format so this func can be used for enfeebs on duration.

xi.magic.applyResistance = function(caster, target, spell, params)
    return xi.magic.applyResistanceEffect(caster, target, spell, params)
end

xi.magic.differentEffect = function(caster, target, spell, params)
    if
        params.effect and
        target:hasStatusEffect(params.effect) and
        utils.ternary(target:getStatusEffect(params.effect):getSubPower() > 0, target:getStatusEffect(params.effect):getSubPower(), 3) >= params.tier
    then
        return false
    end

    return true
end

xi.magic.handleBurstMsg = function(caster, target, spell)
    local element = spell:getElement()

    if element and element ~= xi.magic.ele.NONE then
        local magicBurst = xi.spells.damage.calculateIfMagicBurst(caster, target, spell, element)

        if target:hasStatusEffect(xi.effect.SKILLCHAIN) and (magicBurst > 1) then -- Gated as this is run per target.
            target:triggerListener("MAGIC_BURST_TAKE", caster, target, 0)
            spell:setMsg(spell:getMagicBurstMessage())
            caster:triggerRoeEvent(xi.roe.triggers.magicBurst)
        end
    end
end

xi.magic.handleSMNBurstMsg = function(pet, target, skill, element, mbmsg)
    if element and element ~= xi.magic.ele.NONE then
        local magicBurst = xi.spells.damage.calculateIfMagicBurst(pet, target, skill, element)

        if target:hasStatusEffect(xi.effect.SKILLCHAIN) and (magicBurst > 1) then -- Gated as this is run per target.
            target:triggerListener("MAGIC_BURST_TAKE", pet, target, 0)
            skill:setMsg(mbmsg)
            pet:triggerRoeEvent(xi.roe.triggers.magicBurst)
        end
    end
end

-- USED FOR Status Effect Enfeebs (blind, slow, para, etc.)
-- Output:
-- The factor to multiply down duration (1/2 1/4 1/8 1/16)
--[[
local params = {}
params.attribute = $2
params.skillType = $3
params.bonus = $4
params.effect = $5
]]
xi.magic.applyResistanceEffect = function(caster, target, spell, params)
    local diff = params.diff
    local skill = params.skillType
    local bonus = params.bonus
    local effect = params.effect
    local element = params.element -- Will be nil if this isn't specified.
    local magicaccbonus = 0
    local effectRes = 0

    if diff == nil and params.attribute ~= nil then
        diff = caster:getStat(params.attribute) - target:getStat(params.attribute)
    elseif diff == nil then
        diff = 0
    end

    if element == nil and skill ~= nil and skill >= 32 and skill <= 45 then -- Covers all magic
        element = spell:getElement()
    elseif element == nil then -- Cover mobskills
        element = xi.magic.ele.NONE
    end

    local _, skillchainCount = xi.magic.FormMagicBurst(element, target)

    if spell ~= nil and skill >= 32 and skill <= 45 then
        magicaccbonus = getSpellBonusAcc(caster, target, spell, params)
    end

    if bonus ~= nil then
        magicaccbonus = magicaccbonus + bonus
    end

    if effect ~= nil then
        effectRes = utils.ternary(xi.magic.effectEva[effect], xi.magic.effectEva[effect], 0)
    end

    local p = xi.magic.getMagicHitRate(caster, target, skill, element, effect, effectRes, magicaccbonus, diff, skillchainCount, utils.ternary(params.damageSpell, true, false))

    return xi.magic.getMagicResist(p, target, element, effectRes, skillchainCount, effect, caster, utils.ternary(params.damageSpell, true, false))
end

-- Applies resistance for additional effects
xi.magic.applyResistanceAddEffect = function(player, target, element, effect, bonus, itemSkillType)
    local effectRes = 0

    if effect and target:hasStatusEffect(effect) then
        return 0
    end

    if effect then
        effectRes = utils.ternary(xi.magic.effectEva[effect], xi.magic.effectEva[effect], 0)
    end

    if not element then
        element = xi.magic.ele.NONE
    end

    local dStat = player:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

    local _, skillchainCount = xi.magic.FormMagicBurst(element, target)
    local p = xi.magic.getMagicHitRate(player, target, itemSkillType, element, effect, effectRes, bonus, dStat, skillchainCount, false)
    local resist = xi.magic.getMagicResist(p, target, element, effectRes, skillchainCount, effect, player, false)

    if resist < 0.5 then
        resist = 0
    elseif resist < 1 then
        resist = 0.5
    else
        resist = 1
    end

    return resist
end

xi.magic.applySkillchainResistance = function(player, target, element)
    -- custom horizon change so no SC resist on normal mobs
    if target:isMob() and not target:isNM() then -- normal mobs
        return 1.0
    else -- NMs and everything else
        if not element then
            element = xi.magic.ele.NONE
        end

        local p = xi.magic.getMagicHitRate(player, target, nil, element, nil, 0, 0, 0, 0, true)
        return xi.magic.getMagicResist(p, target, element, 0, 0, nil, player, true)
    end
end

---------------------------------------------------------------------------------------------------
-- This function is used by four distinct upstream usecases
-- 1) Determinging restists for damage on job abilities (Corsair Dmg Shots, Blood Pact: Rage)
-- 2) Determining resists for abilies with an effect (Aura Steal, Modus Veritas, Dark Shot, etc)
-- 3) Applying additional effects via weaponskills (Full Break, )
-- 4) Determining resists for magical weaponskills (or the magical component of hybrid weaponskills)
----------------------------------------------------------------------------------------------------
xi.magic.applyAbilityResistance = function(player, target, params)
    if params.effect and not params.tick then
        params.tick = 0
    end

    if params.effect and not params.power then
        params.power = 1
    end

    if params.effect and target:hasStatusEffect(params.effect) then
        local existingEffect = target:getStatusEffect(params.effect)
        -- only attempt to apply the new effect if the power is greater than the existing effect
        -- this will allow effects like shell crusher to overwrite lower power defense down
        -- note: the final decision on if an effect is applied occurs in CStatusEffectContainer::AddStatusEffect
        if params.power <= existingEffect:getPower() then
            return
        end
    end

    if not params.element then
        params.element = xi.magic.ele.NONE
    end

    if not params.skillType then
        params.skillType = nil
    end

    if params.effect and not params.tick then
        params.tick = 0
    end

    if params.effect and not params.power then
        params.power = 1
    end

    local effectRes = 0

    if params.effect then
        effectRes = utils.ternary(xi.magic.effectEva[params.effect], xi.magic.effectEva[params.effect], 0)
    end

    local dStat = params.dStat
    if dStat == nil then
        dStat = 0
    end

    local skillchainCount = 0
    if params.skillchainCount then
        skillchainCount = params.skillchainCount
    end

    local p = xi.magic.getMagicHitRate(player, target, params.skillType, params.element, params.effect, effectRes, params.maccBonus, dStat, utils.ternary(params.damageSpell))

    -- Nether blast does not have a hit check so return a hit
    if params.netherBlast then
        p = 100
    end

    local resist = xi.magic.getMagicResist(p, target, params.element, effectRes, skillchainCount, params.effect, player, utils.ternary(params.damageSpell, true, false))

    if
        params.effect and
        params.chance and
        params.chance * resist > math.random() * 150 and
        params.duration * resist > 0
    then
        target:addStatusEffect(params.effect, params.power, params.tick, params.duration * resist)
    elseif
        params.effect and
        params.duration * resist > 0 and
        not params.chance
    then
        target:addStatusEffect(params.effect, params.power, params.tick, params.duration * resist)
    else
        return resist
    end
end

-- TODO: Reduce complexity
-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
xi.magic.getMagicHitRate = function(caster, target, skillType, element, effect, effectRes, bonusAcc, dStat, skillchainCount, isDamageSpell, hybridHit)
    xi.msg.debug(caster, "======================")
    xi.msg.debug(caster, "xi.magic.getMagicHitRate")
    xi.msg.debug(caster, "======================")

    local magicacc = 0
    local magiceva = target:getMod(xi.mod.MEVA)
    local resMod = 0
    local dStatAcc = 0

    if hybridHit == nil then
        hybridHit = false
    end

    if not skillchainCount then
        skillchainCount = 0
    end

    -- resist everything if real magic shield is active (see effects/magic_shield)
    if target:hasStatusEffect(xi.effect.MAGIC_SHIELD) then
        local magicshieldsub = target:getStatusEffect(xi.effect.MAGIC_SHIELD)
        if magicshieldsub:getSubPower() == 0 then
            xi.msg.debug(caster, "Magic Shield in Effect")
            xi.msg.debugValue(caster, "Magic Hit Rate", 0)
            xi.msg.debug(caster, "======================")
            return 0
        end
    end

    if bonusAcc == nil then
        bonusAcc = 0
    end

    if dStat == nil then
        dStat = 0
    end

-- DstatAcc is calculated the same for all types of Magic
    local bonusDStat = 0
    dStat = utils.clamp(dStat, -70, 70) -- Dstat can only be as high or low as 70

    if dStat <= -31 then
        bonusDStat = dStat + 30
        dStatAcc = -20 + (bonusDStat / 4)
    elseif dStat <= -11 then
        bonusDStat = dStat + 10
        dStatAcc = -10 + (bonusDStat / 2)
    elseif dStat > -11 and dStat < 11 then
        dStatAcc = dStat
    elseif dStat >= 31 then
        bonusDStat = dStat - 30
        dStatAcc = 20 + (bonusDStat / 4)
    elseif dStat >= 11 then
        bonusDStat = dStat - 10
        dStatAcc = 10 + (bonusDStat / 2)
    end

    xi.msg.debugValue(caster, "dStat", dStat)
    xi.msg.debugValue(caster, "dStatAcc", dStatAcc)

    if
        skillType ~= nil and
        skillType > xi.skill.STAFF and
        (skillType > xi.skill.WIND_INSTRUMENT or skillType < xi.skill.SINGING)
    then -- If not a bard song
        if caster:isPC() then
            local gearBonus = caster:getMod(xi.mod.MACC)
            if skillType >= xi.skill.ARCHERY and  skillType <= xi.skill.THROWING then
                gearBonus = gearBonus + caster:getILvlMacc(xi.slot.RANGED)
            else
                gearBonus = gearBonus + caster:getILvlMacc(xi.slot.MAIN)
            end

            magicacc = caster:getSkillLevel(skillType) + gearBonus + dStatAcc
        else
            magicacc = utils.getSkillLvl(1, caster:getMainLvl()) + dStatAcc + caster:getMod(xi.mod.MACC)
        end

    elseif
        skillType ~= nil and
        (skillType >= xi.skill.SINGING and skillType <= xi.skill.WIND_INSTRUMENT)
    then -- If a bard song
        if caster:isPC() then
            local secondarySkill = 0
            local gearBonus = caster:getMod(xi.mod.MACC) + caster:getILvlMacc(xi.slot.MAIN)

            if caster:getEquippedItem(xi.slot.RANGED) ~= nil then
                secondarySkill = caster:getEquippedItem(xi.slot.RANGED):getSkillType()
            end

            if
                secondarySkill == xi.skill.WIND_INSTRUMENT or
                secondarySkill == xi.skill.STRING_INSTRUMENT
            then
                magicacc = caster:getSkillLevel(skillType) + (caster:getSkillLevel(secondarySkill) / 3) + gearBonus + dStatAcc
            else
                magicacc = caster:getSkillLevel(skillType) + gearBonus + dStatAcc
            end

        else
            magicacc = utils.getSkillLvl(1, caster:getMainLvl()) + dStatAcc + caster:getMod(xi.mod.MACC)
        end
    elseif
        caster:isPC() and
        skillType and
        skillType <= xi.skill.STAFF
    then
        magicacc = dStatAcc + caster:getSkillLevel(skillType) + caster:getMod(xi.mod.MACC)
    elseif
        caster:isPC() and
        not skillType and
        caster:getEquippedItem(xi.slot.MAIN) ~= nil
    then
        magicacc = dStatAcc + caster:getSkillLevel(caster:getEquippedItem(xi.slot.MAIN):getSkillType()) + caster:getMod(xi.mod.MACC)
    elseif
        caster:isMob() and
        skillType == nil
    then
        magicacc = dStatAcc + utils.getSkillLvl(1, caster:getMainLvl()) + caster:getMod(xi.mod.MACC)
    elseif
        caster:isPet() and
        skillType == nil
    then
        magicacc = dStatAcc + utils.getSkillLvl(1, caster:getMainLvl()) + caster:getMod(xi.mod.MACC)
    else
        magicacc = utils.getSkillLvl(4, caster:getMainLvl()) + dStatAcc + caster:getMod(xi.mod.MACC)
    end

    xi.msg.debugValue(caster, "Magic Accuracy", magicacc)

    if element ~= xi.magic.ele.NONE then
        resMod = target:getMod(xi.magic.resistMod[element])
        -- Add acc for elemental affinity accuracy and element specific accuracy
        local affinityBonus = AffinityBonusAcc(caster, element)
        xi.msg.debugValue(caster, "Affinity Bonus", affinityBonus)
        local elementBonus = caster:getMod(spellAcc[element])
        xi.msg.debugValue(caster, "Elemental Bonus", elementBonus)
        bonusAcc = bonusAcc + affinityBonus + elementBonus
        if
            math.random(1, 100) <= 33 or
            caster:getMod(xi.magic.elementalObi[element]) >= 1
        then
            local dayElement = VanadielDayElement()
            -- Strong day.
            if dayElement == element then
                bonusAcc = bonusAcc + 5

            -- Weak day.
            elseif dayElement == xi.magic.elementDescendant[element] then
                bonusAcc = bonusAcc - 5
            end

            local weather = caster:getWeather()
            -- Strong weathers.
            if weather == xi.magic.singleWeatherStrong[element] then
                bonusAcc = bonusAcc + caster:getMod(xi.mod.IRIDESCENCE) * 5 + 5
            elseif weather == xi.magic.doubleWeatherStrong[element] then
                bonusAcc = bonusAcc + caster:getMod(xi.mod.IRIDESCENCE) * 5 + 10

            -- Weak weathers.
            elseif weather == xi.magic.singleWeatherWeak[element] then
                bonusAcc = bonusAcc - caster:getMod(xi.mod.IRIDESCENCE) * 5 - 5
            elseif weather == xi.magic.doubleWeatherWeak[element] then
                bonusAcc = bonusAcc - caster:getMod(xi.mod.IRIDESCENCE) * 5 - 10
            end
        end

        xi.msg.debugValue(caster, "Bonus Magic Accuracy", bonusAcc)
    end

    bonusAcc = bonusAcc + caster:getMerit(xi.merit.MAGIC_ACCURACY) + caster:getMerit(xi.merit.NIN_MAGIC_ACCURACY)

    if effect and target:hasStatusEffect(xi.effect.THRENODY) then
        resMod = handleMevaException(target, effect, xi.effect.THRENODY, element, resMod)
    end

    if effect and target:hasStatusEffect(xi.effect.NINJUTSU_ELE_DEBUFF) then
        resMod = handleMevaException(target, effect, xi.effect.NINJUTSU_ELE_DEBUFF, element, resMod)
    end

    xi.msg.debugValue(caster, "Resistance Mod", resMod)

    xi.msg.debugValue(caster, "Merit-Adjusted Bonus Magic Accuracy", bonusAcc)

    -- If it's a skillchain, aply bonus magic accuracy
    if skillchainCount > 0 then
        magicacc = magicacc + 30
        xi.msg.debugValue(caster, "Skillchain Bonus Magic Accuracy", magicacc)
    end

    -- Apply bonus macc from TandemStrike
    local tandemBonus = xi.magic.handleTandemStrikeBonus(caster)
    if tandemBonus > 0 then
        magicacc = magicacc + tandemBonus
        xi.msg.debugValue(caster, "Tandem Strike Magic Accuracy Bonus", magicacc)
    end

    magicacc = magicacc + bonusAcc

    -- Add macc% from food
    local maccFood = magicacc * (caster:getMod(xi.mod.FOOD_MACCP) / 100)
    magicacc = magicacc + utils.clamp(maccFood, 0, caster:getMod(xi.mod.FOOD_MACC_CAP))
    xi.msg.debugValue(caster, "Food-adjusted Magic Accuracy", magicacc)

    -----------------------------------
    -- Apply level correction.
    -----------------------------------
    local dLvl = target:getMainLvl() - caster:getMainLvl()

    -----------------------------------
    -- STEP 2: Get target magic evasion
    -- Base magic evasion (base magic evasion plus resistances(players), plus elemental defense(mobs)
    -----------------------------------
    if target:isPC() then
        magiceva = magiceva + resMod
        xi.msg.debugValue(caster, "PC Magic Evasion", magiceva)
    else
        dLvl = math.max(dLvl, 0) -- Mobs should not have a disadvantage when targeted
        xi.msg.debugValue(caster, "dLvl", dLvl)
        magiceva = magiceva + (4 * dLvl) + resMod
        xi.msg.debugValue(caster, "Adjusted Magic Evasion", magiceva)
    end

    -----------------------------------
    -- STEP 3: Get Magic Hit Rate
    -----------------------------------
    local hitRate = xi.magic.calculateMagicHitRate(magicacc, magiceva, target, element, skillchainCount, skillType, caster, isDamageSpell, hybridHit, dLvl)
    xi.msg.debugValue(caster, "Magic Hit Rate", hitRate)

    return hitRate
end

-- Returns resistance value from given magic hit rate (p)
xi.magic.getMagicResist = function(magicHitRate, target, element, effectRes, skillchainCount, effect, caster, isDamageSpell)
    xi.msg.debug(caster, "======================")
    xi.msg.debug(caster, "xi.magic.getMagicResist")
    xi.msg.debug(caster, "======================")
    local eemVal = 1
    local resMod = 0
    local eemTier = 0
    local resistTier = utils.ternary(target:isNM(), xi.magic.getBuildResistance(target, xi.magic.resistMod[element]), 0)
    local damageSpell = utils.ternary(isDamageSpell, true, false)

    xi.msg.debugValue(caster, "Base Resist Tier", resistTier)
    xi.msg.debugValue(caster, "Damaging Spell?", utils.ternary(damageSpell, "Yes", "No"))

    if target and element and element ~= xi.magic.ele.NONE and target:isMob() then
        eemTier = utils.clamp(xi.magic.calculateEEMTier(target, element, skillchainCount) + resistTier, -18, 11)
        eemVal  = xi.magic.calculateEEMVal(eemTier)
        xi.msg.debugValue(caster, "EEM Tier", eemTier)
        xi.msg.debugValue(caster, "EEM Value", eemVal)
    end

    local eighthTrigger = false
    local quarterTrigger = false

    if element and element ~= xi.magic.ele.NONE then
        resMod = target:getMod(xi.magic.resistMod[element]) -- MEVA
        xi.msg.debugValue(caster, "Ele Resistance Modifier", resMod)
    end

    if effect and target:hasStatusEffect(xi.effect.THRENODY) then
        resMod = handleMevaException(target, effect, xi.effect.THRENODY, element, resMod)
        xi.msg.debugValue(caster, "Threnody-adjusted Ele Resistance Modifier", resMod)
    end

    if effect and target:hasStatusEffect(xi.effect.NINJUTSU_ELE_DEBUFF) then
        resMod = handleMevaException(target, effect, xi.effect.NINJUTSU_ELE_DEBUFF, element, resMod)
        xi.msg.debugValue(caster, "Ninjutsu-adjusted Ele Resistance Modifier", resMod)
    end

    local resTriggerPoints =
    {
        resMod > 101 or eemTier == 11,
        resMod >= 0,
    }

    if resTriggerPoints[1] and damageSpell then
        eighthTrigger = true
    end

    if resTriggerPoints[2] and damageSpell then
        quarterTrigger = true
    end

    if eemTier == -3 and damageSpell then
        eighthTrigger  = false
        quarterTrigger = false
    end

    xi.msg.debugValue(caster, "Eighth Trigger Met", utils.ternary(eighthTrigger, "Yes", "No"))
    xi.msg.debugValue(caster, "Quarter Trigger Met", utils.ternary(quarterTrigger, "Yes", "No"))

    local baseRes = 1

    if effect then
        baseRes = baseRes - (xi.magic.getEffectResistance(target, effect, false, caster) / 100)
    end

    xi.msg.debugValue(caster, "Effect Resistance Modifer", baseRes)

    local p = utils.clamp((magicHitRate / 100), 0.05, 0.95)
    p = utils.clamp(p * baseRes, -1, 0.95)

    xi.msg.debugValue(caster, "Clamped Magic Hit Rate", p)

    -- if the p value is negative, this is a full 100% resist
    if p <= 0 then
        return 0
    end

    local resist = 1

    -- Resistance thresholds based on p.  A higher p leads to lower resist rates, and a lower p leads to higher resist rates.
    local half      = (1 - p)
    local quart     = ((1 - p)^2)
    local eighth    = ((1 - p)^3)
    local diceRoll  = math.random()

    if eemTier == 11 then
        diceRoll = 0
        xi.msg.debugValue(caster, "I hit Tier 11: Diceroll = 0", diceRoll)
    end

    xi.msg.debugValue(caster, "1/2 Resist State", half)
    xi.msg.debugValue(caster, "1/4 Resist State", quart)
    xi.msg.debugValue(caster, "1/8 Resist State", eighth)
    xi.msg.debugValue(caster, "Dice Roll", diceRoll)

    -- Determine final resist based on which thresholds have been crossed.
    if damageSpell then

        -- First check if the tier is 11 or the diceroll is 0
        if diceRoll == 0 or eemTier == 11 then -- Putting this here as a safeguard
            resist = 0.125
        elseif diceRoll <= eighth and eighthTrigger then -- Then check if it rolls the eigth resist and meets the trigger requirement
            resist = 0.125
        elseif diceRoll <= quart and quarterTrigger then -- Then check if it rolls the quarter resist and meets the trigger requirement
            resist = 0.25
        elseif diceRoll <= half then -- Then check if it rolls the half resist
            resist = 0.5
        else
            resist = 1.0 -- If it fails to meet any of those it means it did not resist
        end
    else
        -- Enefeebles
        if -- If it is eemTier 11 or it does not meet half resist requirements then fail
            diceRoll == 0 or
            eemTier == 11 or
            diceRoll <= quart
        then
            resist = 0
        elseif diceRoll <= half then -- If it is below half then it will half resist
            resist = 0.5
        else
            resist = 1
        end
    end

    -- When EEM is 150%, make sure the lowest resist is 0.5
    if eemTier == -18 and resist < 0.5 and damageSpell then
        resist = 0.5
        xi.msg.debugValue(caster, "150% tier 0.5", resist)
    end

    xi.msg.debugValue(caster, "Resist Tier", resist)

    -- Resistance Rank Reduction
    -- When a monster's resistance rank to an element is 50% or lower, an additional forced resist of 1/2 = 50% is added onto the previous resist, calculated multiplicatively.
    if eemVal <= 0.50 and damageSpell then
        resist = resist / 2
    end

    xi.msg.debugValue(caster, "Final Resist State", resist)

    -- If we're applying a status effect, < 0.5 should be fail, 0.5 is half duration, 1.0 is full duration
    if effect ~= nil and resist < 0.5 then
        resist = 0
        xi.msg.debug(caster, "Status Effect: Resisted")
    elseif effect ~= nil and resist == 0.5 then
        resist = 0.5
        xi.msg.debug(caster, "Status Effect: Half Resist")
    elseif effect ~= nil and resist > 0.5 then
        resist = 1
        xi.msg.debug(caster, "Status Effect: No Resist")
    end

    return resist
end

xi.magic.tryBuildResistance = function(target, resistance, isEnfeeb, caster)
    local baseRes = target:getLocalVar(string.format("[RES]Base_%s", resistance))
    local castCool = target:getLocalVar(string.format("[RES]CastCool_%s", resistance))
    local resBuilt = target:getLocalVar(string.format("[RES]ResTier_%s", resistance))
    local coolTime = 20

    if baseRes == 0 then
        target:setLocalVar(string.format("[RES]Base_%s", resistance), target:getMod(resistance))
    end

    if castCool <= os.time() then -- Reset Mod If 20s Since Last Spell Elapsed
        target:setLocalVar(string.format("[RES]ResTier_%s", resistance), 0) -- Reset BuiltPercent Var
        target:setLocalVar(string.format("[RES]CastCool_%s", resistance), os.time() + coolTime) -- Start Cool Var
        return 0
    else
        target:setLocalVar(string.format("[RES]ResTier_%s", resistance), resBuilt + 1)
        target:setLocalVar(string.format("[RES]CastCool_%s", resistance), os.time() + coolTime)
        resBuilt = target:getLocalVar(string.format("[RES]ResTier_%s", resistance))
        return math.max(resBuilt - 1, 0)
    end
end

xi.magic.getBuildResistance = function(target, resistance)
    local castCool = target:getLocalVar(string.format("[RES]CastCool_%s", resistance))
    local coolTime = 20

    if castCool <= os.time() then -- Reset Mod If 20s Since Last Spell Elapsed
        target:setLocalVar(string.format("[RES]ResTier_%s", resistance), 0) -- Reset BuiltPercent Var
        target:setLocalVar(string.format("[RES]CastCool_%s", resistance), os.time() + coolTime) -- Start Cool Var
        return 0
    else
        local resBuilt = target:getLocalVar(string.format("[RES]ResTier_%s", resistance))
        return math.max(resBuilt - 1, 0)
    end
end

-- Returns the amount of resistance the
-- target has to the given effect (stun, sleep, etc..)
xi.magic.getEffectResistance = function(target, effect, returnBuild, caster)
    local effectres = 0
    local buildres = 0
    local statusres = target:getMod(xi.mod.STATUSRES)
    local ecoBonus = 0
    local resTable =
    {
        [xi.effect.SLEEP_I] = { effectres = xi.mod.SLEEPRES, buildres = xi.mod.SLEEPRESBUILD },
        [xi.effect.SLEEP_II] = { effectres = xi.mod.SLEEPRES, buildres = xi.mod.SLEEPRESBUILD },
        [xi.effect.LULLABY] = { effectres = xi.mod.LULLABYRES, buildres = xi.mod.LULLABYRESBUILD },
        [xi.effect.POISON] = { effectres = xi.mod.POISONRES, buildres = xi.mod.POISONRESBUILD },
        [xi.effect.PARALYSIS] = { effectres = xi.mod.PARALYZERES, buildres = xi.mod.PARALYZERESBUILD },
        [xi.effect.BLINDNESS] = { effectres = xi.mod.BLINDRES, buildres = xi.mod.BLINDRESBUILD },
        [xi.effect.SILENCE] = { effectres = xi.mod.SILENCERES, buildres = xi.mod.SILENCERESBUILD },
        [xi.effect.PLAGUE] = { effectres = xi.mod.VIRUSRES, buildres = xi.mod.VIRUSRESBUILD },
        [xi.effect.PETRIFICATION] = { effectres = xi.mod.PETRIFYRES, buildres = xi.mod.PETRIFYRESBUILD },
        [xi.effect.BIND] = { effectres = xi.mod.BINDRES, buildres = xi.mod.BINDRESBUILD },
        [xi.effect.CURSE_I] = { effectres = xi.mod.CURSERES, buildres = xi.mod.CURSERESBUILD },
        [xi.effect.CURSE_II] = { effectres = xi.mod.CURSERES, buildres = xi.mod.CURSERESBUILD },
        [xi.effect.BANE] = { effectres = xi.mod.CURSERES, buildres = xi.mod.CURSERESBUILD },
        [xi.effect.WEIGHT] = { effectres = xi.mod.GRAVITYRES, buildres = xi.mod.GRAVITYRESBUILD },
        [xi.effect.SLOW] = { effectres = xi.mod.SLOWRES, buildres = xi.mod.SLOWRESBUILD },
        [xi.effect.ELEGY] = { effectres = xi.mod.SLOWRES, buildres = xi.mod.SLOWRESBUILD },
        [xi.effect.STUN] = { effectres = xi.mod.STUNRES, buildres = xi.mod.STUNRESBUILD },
        [xi.effect.CHARM_I] = { effectres = xi.mod.CHARMRES, buildres = xi.mod.CHARMRESBUILD },
        [xi.effect.CHARM_II] = { effectres = xi.mod.CHARMRES, buildres = xi.mod.CHARMRESBUILD },
        [xi.effect.AMNESIA] = { effectres = xi.mod.AMNESIARES, buildres = xi.mod.AMNESIARESBUILD },
    }

    for effectIndex, effectTable in pairs(resTable) do
        if effectIndex == effect then
            effectres = effectTable.effectres
            buildres = effectTable.buildres
            break
        end
    end

    if
        returnBuild ~= nil and
        returnBuild
    then
        return buildres
    end

    if effectres ~= 0 then
        return target:getMod(effectres) + statusres + ecoBonus
    end

    return statusres
end

xi.magic.handleAfflatusMisery = function(caster, spell, dmg)
    if caster:hasStatusEffect(xi.effect.AFFLATUS_MISERY) then
        local misery = caster:getMod(xi.mod.AFFLATUS_MISERY)
        -- According to BGWiki Caps at 300 magic damage.
        local miseryMax = 300

        miseryMax = miseryMax * (1 - caster:getMerit(xi.merit.ANIMUS_MISERY) / 100)

        -- BGwiki puts the boost capping at 200% bonus at 1/4th max HP.
        if misery > miseryMax then
            misery = miseryMax
        end

        -- Damage is 2x at boost cap.
        local boost = 1 + (misery / miseryMax)

        dmg = math.floor(dmg * boost)

        --Afflatus Mod is Used Up
        caster:setMod(xi.mod.AFFLATUS_MISERY, 0)
    end

    return dmg
end

xi.magic.finalMagicAdjustments = function(caster, target, spell, dmg)
    --Handles target's HP adjustment and returns UNSIGNED dmg (absorb message is set in this function)

    -- handle multiple targets
    if caster:isSpellAoE(spell:getID()) then
        local total = spell:getTotalTargets()

        if total > 9 then
            -- ga spells on 10+ targets = 0.4
            dmg = dmg * 0.4
        elseif total > 1 then
            -- -ga spells on 2 to 9 targets = 0.9 - 0.05T where T = number of targets
            dmg = dmg * (0.9 - 0.05 * total)
        end

        -- kill shadows
        -- target:delStatusEffect(xi.effect.COPY_IMAGE)
        -- target:delStatusEffect(xi.effect.BLINK)
    else
        -- this logic will eventually be moved here
        -- dmg = utils.takeShadows(target, mob, dmg, 1)

        -- if (dmg == 0) then
            -- spell:setMsg(xi.msg.basic.SHADOW_ABSORB)
            -- return 1
        -- end
    end

    local skill = spell:getSkillType()
    if skill == xi.skill.ELEMENTAL_MAGIC then
        dmg = dmg * xi.settings.main.ELEMENTAL_POWER
    elseif skill == xi.skill.DARK_MAGIC then
        dmg = dmg * xi.settings.main.DARK_POWER
    elseif skill == xi.skill.NINJUTSU then
        dmg = dmg * xi.settings.main.NINJUTSU_POWER
    elseif skill == xi.skill.DIVINE_MAGIC then
        dmg = dmg * xi.settings.main.DIVINE_POWER
    end

    dmg = target:magicDmgTaken(dmg)

    if dmg > 0 then
        dmg = dmg - target:getMod(xi.mod.PHALANX)
        dmg = utils.clamp(dmg, 0, 99999)
    end

    -- handle one for all
    dmg = utils.oneforall(target, dmg)

    -- Handle Rampart Magic Shield
    dmg = utils.rampart(target, dmg)

    --handling stoneskin
    dmg = utils.stoneskin(target, dmg)
    dmg = utils.clamp(dmg, -99999, 99999)

    if dmg < 0 then
        dmg = target:addHP(-dmg)
        spell:setMsg(xi.msg.basic.MAGIC_RECOVERS_HP)
    else
        target:takeSpellDamage(caster, spell, dmg, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL + spell:getElement())
        target:handleAfflatusMiseryDamage(dmg)
        target:updateEnmityFromDamage(caster, dmg)
        -- Only add TP if the target is a mob
        if target:getObjType() ~= xi.objType.PC and dmg > 0 then
            target:addTP(100)
        end
    end

    return dmg
end

xi.magic.finalMagicNonSpellAdjustments = function(caster, target, ele, dmg)
    -- Handles target's HP adjustment and returns SIGNED dmg (negative values on absorb)

    dmg = target:magicDmgTaken(dmg)

    if dmg > 0 then
        dmg = dmg - target:getMod(xi.mod.PHALANX)
        dmg = utils.clamp(dmg, 0, 99999)
    end

    -- handle one for all
    dmg = utils.oneforall(target, dmg)

    -- Handle Rampart Magic Shield
    if dmg > 0 then
        dmg = utils.clamp(utils.rampart(target, dmg), -99999, 99999)
    end

    -- handling stoneskin
    dmg = utils.stoneskin(target, dmg)

    dmg = utils.clamp(dmg, -99999, 99999)

    if dmg < 0 then
        dmg = -(target:addHP(-dmg))
    else
        target:takeDamage(dmg, caster, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL + ele)
    end

    -- Not updating enmity from damage, as this is primarily used for additional effects (which don't generate emnity)
    --  in the case that updating enmity is needed, do it manually after calling this
    -- target:updateEnmityFromDamage(caster, dmg)

    return dmg
end

xi.magic.adjustForTarget = function(target, dmg, ele)
    if
        dmg > 0 and
        xi.magic.absorbMod[ele] and
        math.random(0, 99) < target:getMod(xi.magic.absorbMod[ele])
    then
        return -dmg
    end

    if nullMod[ele] and math.random(0, 99) < target:getMod(nullMod[ele]) then
        return 0
    end

    --Moved non element specific absorb and null mod checks to core
    --TODO: update all lua calls to magicDmgTaken with appropriate element and remove this function
    return dmg
end

xi.magic.addBonuses = function(caster, spell, target, dmg, params)
    local ele = spell:getElement()
    local affinityBonus = AffinityBonusDmg(caster, ele)
    local magicDefense = xi.magic.getElementalDamageReduction(target, ele)
    local dayWeatherBonus = 1.00
    local weather = caster:getWeather()
    local casterJob = caster:getMainJob()

    params = params or {}
    params.bonusmab = params.bonusmab or 0
    params.AMIIburstBonus = params.AMIIburstBonus or 0

    dmg = math.floor(dmg * affinityBonus)
    dmg = math.floor(dmg * magicDefense)

    local dayWeatherBonusCheck = math.random() < 0.33 or caster:getMod(xi.magic.elementalObi[ele]) >= 1 or isHelixSpell(spell)

    if dayWeatherBonusCheck then
        if weather == xi.magic.singleWeatherStrong[ele] then
            if caster:getMod(xi.mod.IRIDESCENCE) >= 1 then
                dayWeatherBonus = dayWeatherBonus + 0.10
            end

            dayWeatherBonus = dayWeatherBonus + 0.10
        elseif caster:getWeather() == xi.magic.singleWeatherWeak[ele] then
            dayWeatherBonus = dayWeatherBonus - 0.10
        elseif weather == xi.magic.doubleWeatherStrong[ele] then
            if caster:getMod(xi.mod.IRIDESCENCE) >= 1 then
                dayWeatherBonus = dayWeatherBonus + 0.10
            end

            dayWeatherBonus = dayWeatherBonus + 0.25
        elseif weather == xi.magic.doubleWeatherWeak[ele] then
            dayWeatherBonus = dayWeatherBonus - 0.25
        end
    end

    local dayElement = VanadielDayElement()
    if dayWeatherBonusCheck then
        if dayElement == ele then
            dayWeatherBonus = dayWeatherBonus + caster:getMod(xi.mod.DAY_NUKE_BONUS) / 100 -- sorc. tonban(+1)/zodiac ring
            if dayWeatherBonusCheck then
                dayWeatherBonus = dayWeatherBonus + 0.10
            end
        elseif dayElement == xi.magic.elementDescendant[ele] then
            if dayWeatherBonusCheck then
                dayWeatherBonus = dayWeatherBonus - 0.10
            end
        end
    end

    dayWeatherBonus = math.min(dayWeatherBonus, 1.4)

    dmg = math.floor(dmg * dayWeatherBonus)

    local burst = calculateMagicBurst(caster, spell, target, params)

    if burst > 1.0 then
        spell:setMsg(spell:getMagicBurstMessage()) -- "Magic Burst!"

        caster:triggerRoeEvent(xi.roe.triggers.magicBurst)
    end

    dmg = math.floor(dmg * burst)
    local mabbonus = 0
    local spellId = spell:getID()

    if spellId >= 245 and spellId <= 248 then -- Drain/Aspir (II)
        mabbonus = 1 + caster:getMod(xi.mod.ENH_DRAIN_ASPIR) / 100

        if spellId == 247 or spellId == 248 then
            mabbonus = mabbonus + caster:getMerit(xi.merit.ASPIR_ABSORPTION_AMOUNT) / 100
        end
    else
        local mab = caster:getMod(xi.mod.MATT) + params.bonusmab

        if spell:getSkillType() == xi.skill.NINJUTSU then
            mab = mab + caster:getMerit(xi.merit.NIN_MAGIC_BONUS)
        end

        if math.random(1, 100) < caster:getMod(xi.mod.MAGIC_CRITHITRATE) then
            mab = mab + (10 + caster:getMod(xi.mod.MAGIC_CRIT_DMG_INCREASE))
        end

        local mdefBarBonus = 0
        if ele >= xi.magic.ele.FIRE and ele <= xi.magic.ele.WATER then
            mab = mab + caster:getMerit(blmMerit[ele])
            if target:hasStatusEffect(xi.magic.barSpell[ele]) then -- bar- spell magic defense bonus
                mdefBarBonus = target:getStatusEffect(xi.magic.barSpell[ele]):getSubPower()
            end
        end

        if casterJob == xi.job.RDM then
            mab = mab + caster:getJobPointLevel(xi.jp.RDM_MAGIC_ATK_BONUS)
        elseif casterJob == xi.job.GEO then
            mab = mab + caster:getJobPointLevel(xi.jp.GEO_MAGIC_ATK_BONUS)
        end

        mabbonus = (100 + mab) / (100 + target:getMod(xi.mod.MDEF) + mdefBarBonus)
    end

    mabbonus = math.max(0, mabbonus)
    dmg = math.floor(dmg * mabbonus)

    if caster:hasStatusEffect(xi.effect.EBULLIENCE) then
        dmg = dmg * (1.2 + caster:getMod(xi.mod.EBULLIENCE_AMOUNT) / 100)
        caster:delStatusEffectSilent(xi.effect.EBULLIENCE)
    end

    dmg = math.floor(dmg)

    return dmg
end

xi.magic.addBonusesAbility = function(caster, ele, target, dmg, params)
    local affinityBonus = AffinityBonusDmg(caster, ele)
    dmg = math.floor(dmg * affinityBonus)

    local magicDefense = xi.magic.getElementalDamageReduction(target, ele)
    dmg = math.floor(dmg * magicDefense)

    local dayWeatherBonus = 1.00
    local weather = caster:getWeather()

    if
        xi.magic.elementalObi[ele] ~= nil and
        (math.random() < 0.33 or
        caster:getMod(xi.magic.elementalObi[ele]) >= 1)
    then
        if weather == xi.magic.singleWeatherStrong[ele] then
            if caster:getMod(xi.mod.IRIDESCENCE) >= 1 then
                dayWeatherBonus = dayWeatherBonus + 0.10
            end

            dayWeatherBonus = dayWeatherBonus + 0.10
        elseif caster:getWeather() == xi.magic.singleWeatherWeak[ele] then
            dayWeatherBonus = dayWeatherBonus - 0.10
        elseif weather == xi.magic.doubleWeatherStrong[ele] then
            if caster:getMod(xi.mod.IRIDESCENCE) >= 1 then
                dayWeatherBonus = dayWeatherBonus + 0.10
            end

            dayWeatherBonus = dayWeatherBonus + 0.25
        elseif weather == xi.magic.doubleWeatherWeak[ele] then
            dayWeatherBonus = dayWeatherBonus - 0.25
        end
    end

    local dayElement = VanadielDayElement()
    if dayElement == ele then
        dayWeatherBonus = dayWeatherBonus + caster:getMod(xi.mod.DAY_NUKE_BONUS) / 100 -- sorc. tonban(+1)/zodiac ring
        if math.random() < 0.33 or caster:getMod(xi.magic.elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif dayElement == xi.magic.elementDescendant[ele] then
        if math.random() < 0.33 or caster:getMod(xi.magic.elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    end

    dayWeatherBonus = math.min(dayWeatherBonus, 1.4)

    dmg = math.floor(dmg * dayWeatherBonus)

    local mab = 1
    local mdefBarBonus = 0
    if
        ele ~= nil and
        ele >= xi.magic.ele.FIRE and
        ele <= xi.magic.ele.WATER and
        target:hasStatusEffect(xi.magic.barSpell[ele])
    then -- bar- spell magic defense bonus
        mdefBarBonus = target:getStatusEffect(xi.magic.barSpell[ele]):getSubPower()
    end

    if params ~= nil and params.bonusmab ~= nil and params.includemab then
        mab = (100 + caster:getMod(xi.mod.MATT) + params.bonusmab) / (100 + target:getMod(xi.mod.MDEF) + mdefBarBonus)
    elseif params == nil or (params ~= nil and params.includemab) then
        mab = (100 + caster:getMod(xi.mod.MATT)) / (100 + target:getMod(xi.mod.MDEF) + mdefBarBonus)
    end

    if mab < 0 then
        mab = 0
    end

    dmg = math.floor(dmg * mab)

    return dmg
end

-- get elemental damage reduction
xi.magic.getElementalDamageReduction = function(target, element)
    local defense = 1
    if element ~= nil and element > 0 then
        defense = 1 - (target:getMod(xi.magic.specificDmgTakenMod[element]) / 10000)
        return utils.clamp(defense, 0.0, 2.0)
    end

    return defense
end

-----------------------------------
--  Elemental Debuff Potency functions
-----------------------------------

xi.magic.getElementalDebuffDOT = function(INT)
    local DOT = 0
    if INT <= 39 then
        DOT = 1
    elseif INT <= 69 then
        DOT = 2
    elseif INT <= 99 then
        DOT = 3
    elseif INT <= 149 then
        DOT = 4
    else
        DOT = 5
    end

    return DOT
end

xi.magic.getElementalDebuffStatDownFromDOT = function(dot)
    return (dot - 1) * 2 + 5
end

xi.magic.getHelixDuration = function(caster)
    --Dark Arts will further increase Helix duration, but testing is ongoing.

    local casterLevel = caster:getMainLvl()
    local duration = 30 --fallthrough
    if casterLevel <= 39 then
        duration = 30
    elseif casterLevel <= 59 then
        duration = 60
    elseif casterLevel <= 99 then
        duration = 90
    end

    if caster:hasStatusEffect(xi.effect.DARK_ARTS) then
        local jpValue = caster:getJobPointLevel(xi.jp.DARK_ARTS_EFFECT)

        duration = duration + (3 * jpValue)
    end

    return duration
end

xi.magic.handleThrenody = function(caster, target, spell, basePower, baseDuration, modifier)
    -- Process resitances
    local staff  = AffinityBonusAcc(caster, spell:getElement())
    local params = {}

    params.attribute = xi.mod.CHR
    params.skillType = xi.skill.SINGING
    params.bonus = staff

    local resm = xi.magic.applyResistance(caster, target, spell, params)

    if resm < 0.5 then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        return xi.effect.THRENODY
    end

    -- Remove previous Threnody
    target:delStatusEffect(xi.effect.THRENODY)

    local iBoost = caster:getMod(xi.mod.THRENODY_EFFECT) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)
    local power = basePower + iBoost * 5
    local duration = baseDuration * ((iBoost * 0.1) + (caster:getMod(xi.mod.SONG_DURATION_BONUS) / 100) + 1)

    if caster:hasStatusEffect(xi.effect.SOUL_VOICE) then
        power = power * 2
    elseif caster:hasStatusEffect(xi.effect.MARCATO) then
        power = power * 1.5
    end

    if caster:hasStatusEffect(xi.effect.TROUBADOUR) then
        duration = duration * 2
    end

    -- Set spell message and apply status effect
    target:addStatusEffect(xi.effect.THRENODY, power, 0, duration, 0, modifier, 0)

    return xi.effect.THRENODY
end

xi.magic.handleNinjutsuDebuff = function(caster, target, spell, basePower, baseDuration, modifier)
    -- Add new
    target:addStatusEffectEx(xi.effect.NINJUTSU_ELE_DEBUFF, 0, basePower, 0, baseDuration, 0, modifier, 0)
    return xi.effect.NINJUTSU_ELE_DEBUFF
end

-- Returns true if you can overwrite the effect
-- Example: xi.magic.canOverwrite(target, xi.effect.SLOW, 25)
xi.magic.canOverwrite = function(target, effect, power, mod)
    mod = mod or 1

    local statusEffect = target:getStatusEffect(effect)

    -- effect not found so overwrite
    if statusEffect == nil then
        return true
    end

    -- overwrite if its weaker
    if statusEffect:getPower() * mod > power then
        return false
    end

    return true
end

xi.magic.calculateDurationForLvl = function(duration, spellLvl, targetLvl)
    if targetLvl < spellLvl then
        return duration * targetLvl / spellLvl
    end

    return duration
end

xi.magic.calculateDuration = function(duration, magicSkill, spellGroup, caster, target, useComposure)
    local casterJob = caster:getMainJob()

    if magicSkill == xi.skill.ENHANCING_MAGIC then -- Enhancing Magic
        -- Gear mods
        duration = duration + duration * caster:getMod(xi.mod.ENH_MAGIC_DURATION) / 100

        -- prior according to bg-wiki
        if casterJob == xi.job.RDM then
            duration = duration + caster:getMerit(xi.merit.ENHANCING_MAGIC_DURATION) + caster:getJobPointLevel(xi.jp.ENHANCING_DURATION)
        end

        -- Default is true
        useComposure = useComposure or (useComposure == nil and true)

        -- Composure
        if
            useComposure and
            caster:hasStatusEffect(xi.effect.COMPOSURE) and
            caster:getID() == target:getID()
        then
            duration = duration * 3
        end

        -- Perpetuance
        if
            caster:hasStatusEffect(xi.effect.PERPETUANCE) and
            spellGroup == xi.magic.spellGroup.WHITE
        then
            duration  = duration * 2
        end
    elseif magicSkill == xi.skill.ENFEEBLING_MAGIC then -- Enfeebling Magic
        if caster:hasStatusEffect(xi.effect.SABOTEUR) then
            if target:isNM() then
                duration = duration * 1.25
            else
                duration = duration * 2
            end
        end

        -- After Saboteur according to bg-wiki
        if casterJob == xi.job.RDM then
            -- RDM Merit: Enfeebling Magic Duration
            duration = duration + caster:getMerit(xi.merit.ENFEEBLING_MAGIC_DURATION)

            -- RDM Job Point: Enfeebling Magic Duration
            duration = duration + caster:getJobPointLevel(xi.jp.ENFEEBLE_DURATION)

            -- RDM Job Point: Stymie effect
            if caster:hasStatusEffect(xi.effect.STYMIE) then
                duration = duration + caster:getJobPointLevel(xi.jp.STYMIE_EFFECT)
            end
        end
    elseif magicSkill == xi.skill.DARK_MAGIC then
        duration = duration * (1 + (caster:getMod(xi.mod.DARK_MAGIC_DURATION) / 100))
    end

    return math.floor(duration)
end

xi.magic.incrementBuildDuration = function(target, effect, caster)
    if target:isMob() and target:isNM() then
        local resType = xi.magic.getEffectResistance(target, effect, true, caster)

        local buildResMod = target:getMod(resType)

        if buildResMod ~= nil then
            local durationDecrease = target:getLocalVar(string.format("[RESBUILD]Base_%s", resType))
            local spellCount = target:getLocalVar(string.format("[RESBUILD]Base_%s_Count", resType))

            -- find next duration decrease with min of 1 second (MOD <= 10) and max of 100 seconds (MOD >= 1000)
            local nextDecrease = utils.clamp(math.floor(buildResMod / 10), 1, 100)

            target:setLocalVar(string.format("[RESBUILD]Base_%s", resType), durationDecrease + nextDecrease)
            target:setLocalVar(string.format("[RESBUILD]Base_%s_Count", resType), spellCount + 1)
            -- set local var to denote that these res should be reset when mob roams at 100% HP
            if target:getLocalVar("HasStatusResBuild") == 0 then
                target:setLocalVar("HasStatusResBuild", 1)
            end
        end
    end
end

xi.magic.calculateBuildDuration = function(target, duration, effect, caster)
    if target:isMob() and target:isNM() then
        local resType = xi.magic.getEffectResistance(target, effect, true, caster)

        local buildResMod = target:getMod(resType)

        if buildResMod ~= nil then
            local durationDecrease = target:getLocalVar(string.format("[RESBUILD]Base_%s", resType))
            duration = utils.clamp(duration - durationDecrease, 0, 65535) -- Used to add more fidelity to the build. Adding a mod of 30 will be -3 seconds per cast.
        end
    end

    return duration
end

xi.magic.resetResBuild = function(entity, buildRes)
    entity:setLocalVar(string.format("[RESBUILD]Base_%s", buildRes), 0)
end

xi.magic.calculatePotency = function(basePotency, magicSkill, caster, target)
    if magicSkill ~= xi.skill.ENFEEBLING_MAGIC then
        return basePotency
    end

    if caster:hasStatusEffect(xi.effect.SABOTEUR) then
        if target:isNM() then
            basePotency = math.floor(basePotency * (1.3 + caster:getMod(xi.mod.ENHANCES_SABOTEUR)))
        else
            basePotency = math.floor(basePotency * (2 + caster:getMod(xi.mod.ENHANCES_SABOTEUR)))
        end
    end

    return math.floor(basePotency * (1 + caster:getMod(xi.mod.ENF_MAG_POTENCY) / 100))
end

xi.magic.doAbsorbSpell = function(caster, target, spell, params)
    local resist = xi.magic.applyResistanceEffect(caster, target, spell, params)
    local isAbsorbTp = params.msg == xi.msg.basic.MAGIC_ABSORB_TP
    local spellTable =
    {
        [true] =
        {
            base = utils.clamp((target:getTP() * 0.40) * resist, 0, 1200),
            duration = params.baseDuration,
            returnVal = utils.clamp((target:getTP() * 0.40) * resist, 0, 1200),
        },
        [false] =
        {
            base = 3 + (caster:getMainLvl() / 5),
            duration = (params.baseDuration + caster:getMod(xi.mod.AUGMENTS_ABSORB)) * resist,
            returnVal = params.effect,
        }
    }

    if
        not isAbsorbTp and
        (target:hasStatusEffect(params.effect) or
        caster:hasStatusEffect(params.bonusEffect))
    then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return params.failReturn
    end

    if resist < 0.5 then
        spell:setMsg(params.msgFail)
        return params.failReturn
    end

    spell:setMsg(params.msg)

    if isAbsorbTp then
        caster:addTP(spellTable[isAbsorbTp].base)
        target:addTP(-spellTable[isAbsorbTp].base)
    else
        caster:addStatusEffect(params.bonusEffect, spellTable[isAbsorbTp].base, 8, spellTable[isAbsorbTp].duration)
        target:addStatusEffect(params.effect, spellTable[isAbsorbTp].base, 8, spellTable[isAbsorbTp].duration)
    end

    return spellTable[isAbsorbTp].returnVal
end

xi.magic.getCharmChance = function(charmer, target, includeCharmAffinityAndChanceMods, isMaidensVirelai)
    if isMaidensVirelai == nil then
        isMaidensVirelai = false
    end

    -- Paranoid check
    if
        (not charmer or not target) or                            -- Invalid params
        not target:isMob() or                                     -- Not a mob
        target:getMobMod(xi.mobMod.CHARMABLE) == 0 or             -- Not charmable
        (target:getMaster() ~= nil and target:getMaster():isPC()) -- Someone else's pet
    then
        return 0
    end

    -- Formula:
    -- ((50% - CharmRes%) - dLvl) * CharmMult. + dCHR + StaffBonus
    local charmerLevel    = charmer:getMainLvl()
    local targetLevel     = target:getMainLvl()
    local charmres        = target:getMod(xi.mod.CHARMRES)
    local charmChance     = 50 - charmres
    local charmerJobLevel = 0

    if charmer:isPC() then
        if isMaidensVirelai then
            charmerJobLevel = charmer:getJobLevel(xi.job.BRD)
        else
            charmerJobLevel = charmer:getJobLevel(xi.job.BST)
        end
    else
        charmerJobLevel = charmerLevel
    end

    -- dLvl varies for different level ranges
    if targetLevel >= 71 then
        charmChance = charmChance - 10 * (targetLevel - charmerJobLevel)
    elseif targetLevel >= 51 then
        charmChance = charmChance - 5 * (targetLevel - charmerJobLevel)
    else
        charmChance = charmChance - 3 * (targetLevel - charmerJobLevel)
    end

    -- Multiplier determined by target's light EEM
    local eem = target:getMod(xi.mod.LIGHT_EEM)
    if eem >= 150 then
        charmChance = charmChance * 1.5
    elseif eem >= 130 then
        charmChance = charmChance * 1.4
    elseif eem >= 115 then
        charmChance = charmChance * 1.2
    elseif eem >= 100 then
        charmChance = charmChance
    else
        charmChance = charmChance / 2
    end

    -- Retail doesn't take Light/Apollo staves into account for Gauge
    if includeCharmAffinityAndChanceMods then
        -- NQ elemental staves have 2 affinity, HQ have 3 affinity. Boost is 10/15% respectively so multiply by 5.
        charmChance = charmChance + (5 * charmer:getMod(xi.mod.LIGHT_AFFINITY_ACC))
    end

    local dCHR = charmer:getStat(xi.mod.CHR) - target:getStat(xi.mod.CHR)
    charmChance = charmChance + dCHR

    return utils.clamp(charmChance, 0, 95)
end

xi.magic.calculateEEMTier = function(target, element, skillchainCount)
    local eemTier = 1

    if not skillchainCount then
        skillchainCount = 0
    end

    if
        target ~= nil and
        element ~= nil and
        element ~= xi.magic.ele.NONE and
        target:getObjType() == xi.objType.MOB
    then
        local eemVal = target:getMod(xi.magic.eleEvaMult[element]) / 100 -- 0.05
        for _, eemTable in pairs(xi.magic.eemTiers) do -- Finds the highest tier for the resist.
            if eemVal >= eemTable.eem and eemTable.baseTier then
                eemTier = utils.clamp(eemTable.tier, -18, 11)
                break
            end
        end

        -- Handles increasing EEM Tier if a skillchain is present on the mob
        if skillchainCount > 0 then
            eemTier = utils.clamp(eemTier - 1, -18, 11)
        end

        if target:hasStatusEffect(xi.magic.eemStatus[element]) then
            eemTier = utils.clamp(eemTier - target:getStatusEffect(xi.magic.eemStatus[element]):getPower(), -18, 11)
        end
    end

    return eemTier
end

xi.magic.calculateEEMVal = function(tier)
    local eemVal = 0
    for _, eemTable in pairs(xi.magic.eemTiers) do
        if tier == eemTable.tier then
            eemVal = eemTable.eem
            break
        end
    end

    return eemVal
end

xi.magic.calculateMEVAMult = function(tier)
    local eemVal = 0
    for _, eemTable in pairs(xi.magic.eemTiers) do
        if tier == eemTable.tier then
            eemVal = eemTable.mult
            break
        end
    end

    return eemVal
end

xi.magic.handleTandemStrikeBonus = function(caster)
    if
        caster:getMod(xi.mod.TANDEM_STRIKE) > 0 and
        caster:isTandemValid()
    then
        return caster:getMod(xi.mod.TANDEM_STRIKE)
    elseif
        (caster:getMaster() ~= nil and
        caster:getMaster():getMod(xi.mod.TANDEM_STRIKE) > 0) and
        caster:isTandemValid()
    then
        return caster:getMaster():getMod(xi.mod.TANDEM_STRIKE)
    end

    return 0
end
