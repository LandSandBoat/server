require("scripts/globals/spell_data")
require("scripts/globals/jobpoints")
require("scripts/globals/magicburst")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------

xi = xi or {}
xi.magic = xi.magic or {}

-----------------------------------
-- Tables by element
-----------------------------------

xi.magic.dayStrong           = {xi.day.FIRESDAY,              xi.day.ICEDAY,               xi.day.WINDSDAY,               xi.day.EARTHSDAY,              xi.day.LIGHTNINGDAY,               xi.day.WATERSDAY,               xi.day.LIGHTSDAY,           xi.day.DARKSDAY}
xi.magic.singleWeatherStrong = {xi.weather.HOT_SPELL,         xi.weather.SNOW,             xi.weather.WIND,               xi.weather.DUST_STORM,         xi.weather.THUNDER,                xi.weather.RAIN,                xi.weather.AURORAS,         xi.weather.GLOOM}
xi.magic.doubleWeatherStrong = {xi.weather.HEAT_WAVE,         xi.weather.BLIZZARDS,        xi.weather.GALES,              xi.weather.SAND_STORM,         xi.weather.THUNDERSTORMS,          xi.weather.SQUALL,              xi.weather.STELLAR_GLARE,   xi.weather.DARKNESS}
local elementalObi           = {xi.mod.FORCE_FIRE_DWBONUS,    xi.mod.FORCE_ICE_DWBONUS,    xi.mod.FORCE_WIND_DWBONUS,     xi.mod.FORCE_EARTH_DWBONUS,    xi.mod.FORCE_LIGHTNING_DWBONUS,    xi.mod.FORCE_WATER_DWBONUS,     xi.mod.FORCE_LIGHT_DWBONUS, xi.mod.FORCE_DARK_DWBONUS}
local spellAcc               = {xi.mod.FIREACC,               xi.mod.ICEACC,               xi.mod.WINDACC,                xi.mod.EARTHACC,               xi.mod.THUNDERACC,                 xi.mod.WATERACC,                xi.mod.LIGHTACC,            xi.mod.DARKACC}
local strongAffinityDmg      = {xi.mod.FIRE_AFFINITY_DMG,     xi.mod.ICE_AFFINITY_DMG,     xi.mod.WIND_AFFINITY_DMG,      xi.mod.EARTH_AFFINITY_DMG,     xi.mod.THUNDER_AFFINITY_DMG,       xi.mod.WATER_AFFINITY_DMG,      xi.mod.LIGHT_AFFINITY_DMG,  xi.mod.DARK_AFFINITY_DMG}
local strongAffinityAcc      = {xi.mod.FIRE_AFFINITY_ACC,     xi.mod.ICE_AFFINITY_ACC,     xi.mod.WIND_AFFINITY_ACC,      xi.mod.EARTH_AFFINITY_ACC,     xi.mod.THUNDER_AFFINITY_ACC,       xi.mod.WATER_AFFINITY_ACC,      xi.mod.LIGHT_AFFINITY_ACC,  xi.mod.DARK_AFFINITY_ACC}
xi.magic.resistMod           = {xi.mod.FIRERES,               xi.mod.ICERES,               xi.mod.WINDRES,                xi.mod.EARTHRES,               xi.mod.THUNDERRES,                 xi.mod.WATERRES,                xi.mod.LIGHTRES,            xi.mod.DARKRES}
xi.magic.defenseMod          = {xi.mod.FIREDEF,               xi.mod.ICEDEF,               xi.mod.WINDDEF,                xi.mod.EARTHDEF,               xi.mod.THUNDERDEF,                 xi.mod.WATERDEF,                xi.mod.LIGHTDEF,            xi.mod.DARKDEF}
xi.magic.absorbMod           = {xi.mod.FIRE_ABSORB,           xi.mod.ICE_ABSORB,           xi.mod.WIND_ABSORB,            xi.mod.EARTH_ABSORB,           xi.mod.LTNG_ABSORB,                xi.mod.WATER_ABSORB,            xi.mod.LIGHT_ABSORB,        xi.mod.DARK_ABSORB}
local nullMod                = {xi.mod.FIRE_NULL,             xi.mod.ICE_NULL,             xi.mod.WIND_NULL,              xi.mod.EARTH_NULL,             xi.mod.LTNG_NULL,                  xi.mod.WATER_NULL,              xi.mod.LIGHT_NULL,          xi.mod.DARK_NULL}
local blmMerit               = {xi.merit.FIRE_MAGIC_POTENCY,  xi.merit.ICE_MAGIC_POTENCY,  xi.merit.WIND_MAGIC_POTENCY,   xi.merit.EARTH_MAGIC_POTENCY,  xi.merit.LIGHTNING_MAGIC_POTENCY,  xi.merit.WATER_MAGIC_POTENCY}
local rdmMerit               = {xi.merit.FIRE_MAGIC_ACCURACY, xi.merit.ICE_MAGIC_ACCURACY, xi.merit.WIND_MAGIC_ACCURACY,  xi.merit.EARTH_MAGIC_ACCURACY, xi.merit.LIGHTNING_MAGIC_ACCURACY, xi.merit.WATER_MAGIC_ACCURACY}
xi.magic.barSpell            = {xi.effect.BARFIRE,            xi.effect.BARBLIZZARD,       xi.effect.BARAERO,             xi.effect.BARSTONE,            xi.effect.BARTHUNDER,              xi.effect.BARWATER}

xi.magic.dayWeak             = {xi.day.WATERSDAY,             xi.day.FIRESDAY,             xi.day.ICEDAY,                 xi.day.WINDSDAY,               xi.day.EARTHSDAY,                  xi.day.LIGHTNINGDAY,            xi.day.DARKSDAY,            xi.day.LIGHTSDAY           }
xi.magic.singleWeatherWeak   = {xi.weather.RAIN,              xi.weather.HOT_SPELL,        xi.weather.SNOW,               xi.weather.WIND,               xi.weather.DUST_STORM,             xi.weather.THUNDER,             xi.weather.GLOOM,           xi.weather.AURORAS         }
xi.magic.doubleWeatherWeak   = {xi.weather.SQUALL,            xi.weather.HEAT_WAVE,        xi.weather.BLIZZARDS,          xi.weather.GALES,              xi.weather.SAND_STORM,             xi.weather.THUNDERSTORMS,       xi.weather.DARKNESS,        xi.weather.STELLAR_GLARE   }

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
local SOFT_CAP = 60 --guesstimated
local HARD_CAP = 120 --guesstimated

function calculateMagicDamage(caster, target, spell, params)

    local dINT = caster:getStat(params.attribute) - target:getStat(params.attribute)
    local dmg = params.dmg

    if dINT <= 0 then --if dINT penalises, it's always M=1
        dmg = dmg + dINT
        if dmg <= 0 then --dINT penalty cannot result in negative damage (target absorption)
            return 0
        end
    elseif dINT > 0 and dINT <= SOFT_CAP then --The standard calc, most spells hit this
        dmg = dmg + (dINT * params.multiplier)
    elseif dINT > 0 and dINT > SOFT_CAP and dINT < HARD_CAP then --After SOFT_CAP, INT is only half effective
        dmg = dmg + SOFT_CAP * params.multiplier + ((dINT - SOFT_CAP) * params.multiplier) / 2
    elseif dINT > 0 and dINT > SOFT_CAP and dINT >= HARD_CAP then --After HARD_CAP, INT has no xi.effect.
        dmg = dmg + HARD_CAP * params.multiplier
    end


    if params.skillType == xi.skill.DIVINE_MAGIC and target:isUndead() then
        -- 150% bonus damage
        dmg = dmg * 1.5
    end

    -- printf("dmg: %d dINT: %d\n", dmg, dINT)

    return dmg

end

function doBoostGain(caster, target, spell, effect)
    local duration = calculateDuration(300, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    --calculate potency
    local magicskill = target:getSkillLevel(spell:getSkillType())

    local potency = math.floor((magicskill - 300) / 10) + 5

    if potency > 25 then
        potency = 25
    elseif potency < 5 then
        potency = 5
    end

    --printf("BOOST-GAIN: POTENCY = %d", potency)

    --Only one Boost Effect can be active at once, so if the player has any we have to cancel & overwrite
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

    for i, effect in ipairs(effectOverwrite) do
            --printf("BOOST-GAIN: CHECKING FOR EFFECT %d...", effect)
            if caster:hasStatusEffect(effect) then
                --printf("BOOST-GAIN: HAS EFFECT %d, DELETING...", effect)
                caster:delStatusEffect(effect)
            end
    end

    if target:addStatusEffect(effect, potency, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end
end

function doEnspell(caster, target, spell, effect)
    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    --calculate potency
    local magicskill = caster:getSkillLevel(xi.skill.ENHANCING_MAGIC)

    local potency = 3 + math.floor(6 * magicskill / 100)
    if magicskill > 200 then
        potency = 5 + math.floor(5 * magicskill / 100)
    end

    if target:addStatusEffect(effect, potency, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end
end

-----------------------------------
--   getCurePower returns the caster's cure power
--   getCureFinal returns the final cure amount
--   Source: http://members.shaw.ca/pizza_steve/cure/Cure_Calculator.html
-----------------------------------
function getCurePower(caster, isBlueMagic)
    local MND = caster:getStat(xi.mod.MND)
    local VIT = caster:getStat(xi.mod.VIT)
    local skill = caster:getSkillLevel(xi.skill.HEALING_MAGIC)
    local power = math.floor(MND/2) + math.floor(VIT/4) + skill
    return power
end

function getCurePowerOld(caster)
    local MND = caster:getStat(xi.mod.MND)
    local VIT = caster:getStat(xi.mod.VIT)
    local skill = caster:getSkillLevel(xi.skill.HEALING_MAGIC) -- it's healing magic skill for the BLU cures as well
    local power = (3 * MND) + VIT + (3 * math.floor(skill/5))
    return power
end

function getBaseCure(power, divisor, constant, basepower)
    return ((power - basepower) / divisor) + constant
end

function getBaseCureOld(power, divisor, constant)
    return (power / 2) / divisor + constant
end

function getCureFinal(caster, spell, basecure, minCure, isBlueMagic)
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
    if isBlueMagic == false then --rapture doesn't affect BLU cures as they're not white magic
        if caster:hasStatusEffect(xi.effect.RAPTURE) then
            rapture = 1.5 + caster:getMod(xi.mod.RAPTURE_AMOUNT)/100
            caster:delStatusEffectSilent(xi.effect.RAPTURE)
        end
    end

    local dayWeatherBonus = 1
    local ele = spell:getElement()

    local castersWeather = caster:getWeather()

    if castersWeather == xi.magic.singleWeatherStrong[ele] then
        if caster:getMod(xi.mod.IRIDESCENCE) >= 1 then
            if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
                dayWeatherBonus = dayWeatherBonus + 0.10
            end
        end
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif castersWeather == xi.magic.singleWeatherWeak[ele] then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    elseif castersWeather == xi.magic.doubleWeatherStrong[ele] then
        if caster:getMod(xi.mod.IRIDESCENCE) >= 1 then
            if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
                dayWeatherBonus = dayWeatherBonus + 0.10
            end
        end
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.25
        end
    elseif castersWeather == xi.magic.doubleWeatherWeak[ele] then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus - 0.25
        end
    end

    local dayElement = VanadielDayElement()
    if dayElement == ele then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif dayElement == xi.magic.elementDescendant[ele] then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    end

    if dayWeatherBonus > 1.4 then
        dayWeatherBonus = 1.4
    end

    local final = math.floor(math.floor(math.floor(math.floor(basecure) * potency) * dayWeatherBonus) * rapture) * dSeal
    return final
end

function getCureAsNukeFinal(caster, spell, power, divisor, constant, basepower)
    return getCureFinal(caster, spell, power, divisor, constant, basepower)
end

function isValidHealTarget(caster, target)
    return target:getAllegiance() == caster:getAllegiance() and
            (target:getObjType() == xi.objType.PC or
            target:getObjType() == xi.objType.MOB or
            target:getObjType() == xi.objType.TRUST or
            target:getObjType() == xi.objType.FELLOW)
end

-----------------------------------
-- Returns the staff bonus for the caster and spell.
-----------------------------------

-- affinities that strengthen/weaken the index element


function AffinityBonusDmg(caster, ele)

    local affinity = caster:getMod(strongAffinityDmg[ele])
    local bonus = 1.00 + affinity * 0.05 -- 5% per level of affinity
    -- print(bonus)
    return bonus
end

function AffinityBonusAcc(caster, ele)

    local affinity = caster:getMod(strongAffinityAcc[ele])
    local bonus = 0 + affinity * 10 -- 10 acc per level of affinity
    -- print(bonus)
    return bonus
end

-- USED FOR DAMAGING MAGICAL SPELLS. Stage 3 of Calculating Magic Damage on wiki
-- Reduces damage ifit resists.
--
-- Output:
-- The factor to multiply down damage (1/2 1/4 1/8 1/16) - In this format so this func can be used for enfeebs on duration.

function applyResistance(caster, target, spell, params)
    return applyResistanceEffect(caster, target, spell, params)
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
function applyResistanceEffect(caster, target, spell, params)
    local diff = params.diff or (caster:getStat(params.attribute) - target:getStat(params.attribute))
    local skill = params.skillType
    local bonus = params.bonus
    local effect = params.effect

    -- If Stymie is active, as long as the mob is not immune then the effect is not resisted
    if effect ~= nil then -- Dispel's script doesn't have an "effect" to send here, nor should it.
        if skill == xi.skill.ENFEEBLING_MAGIC and caster:hasStatusEffect(xi.effect.STYMIE) and target:canGainStatusEffect(effect) then
            caster:delStatusEffect(xi.effect.STYMIE)
            return 1
        end
    end

    if skill == xi.skill.SINGING and caster:hasStatusEffect(xi.effect.TROUBADOUR) then
        if math.random(0, 99) < caster:getMerit(xi.merit.TROUBADOUR)-25 then
            return 1.0
        end
    end

    local element = spell:getElement()
    local percentBonus = 0
    local magicaccbonus = getSpellBonusAcc(caster, target, spell, params)

    if diff > 10 then
        magicaccbonus = magicaccbonus + 10 + (diff - 10)/2
    else
        magicaccbonus = magicaccbonus + diff
    end

    if bonus ~= nil then
        magicaccbonus = magicaccbonus + bonus
    end

    if effect ~= nil then
        percentBonus = percentBonus - getEffectResistance(target, effect)
    end

    local p = getMagicHitRate(caster, target, skill, element, percentBonus, magicaccbonus)

    return getMagicResist(p)
end

-- Applies resistance for things that may not be spells - ie. Quick Draw
function applyResistanceAbility(player, target, element, skill, bonus)
    local p = getMagicHitRate(player, target, skill, element, 0, bonus)

    return getMagicResist(p)
end

-- Applies resistance for additional effects
function applyResistanceAddEffect(player, target, element, bonus)

    local p = getMagicHitRate(player, target, 0, element, 0, bonus)

    return getMagicResist(p)
end

function getMagicHitRate(caster, target, skillType, element, percentBonus, bonusAcc)
    -- resist everything if magic shield is active
    if target:hasStatusEffect(xi.effect.MAGIC_SHIELD, 0) then
        return 0
    end

    local magiceva = 0

    if bonusAcc == nil then
        bonusAcc = 0
    end

    local magicacc = caster:getMod(xi.mod.MACC) + caster:getILvlMacc()

    -- Get the base acc (just skill + skill mod (79 + skillID = ModID) + magic acc mod)
    if skillType ~= 0 then
        magicacc = magicacc + caster:getSkillLevel(skillType)
    else
        -- for mob skills / additional effects which don't have a skill
        magicacc = magicacc + utils.getSkillLvl(1, caster:getMainLvl())
    end

    local resMod = 0 -- Some spells may possibly be non elemental, but have status effects.
    if element ~= xi.magic.ele.NONE then
        resMod = target:getMod(xi.magic.resistMod[element])

        -- Add acc for elemental affinity accuracy and element specific accuracy
        local affinityBonus = AffinityBonusAcc(caster, element)
        local elementBonus = caster:getMod(spellAcc[element])
        -- print(elementBonus)
        bonusAcc = bonusAcc + affinityBonus + elementBonus
    end

    magicacc = magicacc + caster:getMerit(xi.merit.MAGIC_ACCURACY)

    magicacc = magicacc + caster:getMerit(xi.merit.NIN_MAGIC_ACCURACY)

    -- Base magic evasion (base magic evasion plus resistances(players), plus elemental defense(mobs)
    local magiceva = target:getMod(xi.mod.MEVA) + resMod

    magicacc = magicacc + bonusAcc

    -- Add macc% from food
    local maccFood = magicacc * (caster:getMod(xi.mod.FOOD_MACCP)/100)
    magicacc = magicacc + utils.clamp(maccFood, 0, caster:getMod(xi.mod.FOOD_MACC_CAP))

    return calculateMagicHitRate(magicacc, magiceva, percentBonus, caster:getMainLvl(), target:getMainLvl())
end

function calculateMagicHitRate(magicacc, magiceva, percentBonus, casterLvl, targetLvl)
    local p = 0
    --add a scaling bonus or penalty based on difference of targets level from caster
    local levelDiff = utils.clamp(casterLvl - targetLvl, -5, 5)

    p = 70 - 0.5 * (magiceva - magicacc) + levelDiff * 3 + percentBonus

    return utils.clamp(p, 5, 95)
end

-- Returns resistance value from given magic hit rate (p)
function getMagicResist(magicHitRate)

    local p = magicHitRate / 100
    local resist = 1

    -- Resistance thresholds based on p.  A higher p leads to lower resist rates, and a lower p leads to higher resist rates.
    local half = (1 - p)
    local quart = ((1 - p)^2)
    local eighth = ((1 - p)^3)
    local sixteenth = ((1 - p)^4)
    -- print("HALF: "..half)
    -- print("QUART: "..quart)
    -- print("EIGHTH: "..eighth)
    -- print("SIXTEENTH: "..sixteenth)

    local resvar = math.random()

    -- Determine final resist based on which thresholds have been crossed.
    if resvar <= sixteenth then
        resist = 0.0625
        --printf("Spell resisted to 1/16!!!  Threshold = %u", sixteenth)
    elseif resvar <= eighth then
        resist = 0.125
        --printf("Spell resisted to 1/8!  Threshold = %u", eighth)
    elseif resvar <= quart then
        resist = 0.25
        --printf("Spell resisted to 1/4.  Threshold = %u", quart)
    elseif resvar <= half then
        resist = 0.5
        --printf("Spell resisted to 1/2.  Threshold = %u", half)
    else
        resist = 1.0
        --printf("1.0")
    end

    return resist
end

-- Returns the amount of resistance the
-- target has to the given effect (stun, sleep, etc..)
function getEffectResistance(target, effect)
    local effectres = 0
    local statusres = target:getMod(xi.mod.STATUSRES)
    if effect == xi.effect.SLEEP_I or effect == xi.effect.SLEEP_II then
        effectres = xi.mod.SLEEPRES
    elseif effect == xi.effect.LULLABY then
        effectres = xi.mod.LULLABYRES
    elseif effect == xi.effect.POISON then
        effectres = xi.mod.POISONRES
    elseif effect == xi.effect.PARALYSIS then
        effectres = xi.mod.PARALYZERES
    elseif effect == xi.effect.BLINDNESS then
        effectres = xi.mod.BLINDRES
    elseif effect == xi.effect.SILENCE then
        effectres = xi.mod.SILENCERES
    elseif effect == xi.effect.PLAGUE or effect == xi.effect.DISEASE then
        effectres = xi.mod.VIRUSRES
    elseif effect == xi.effect.PETRIFICATION then
        effectres = xi.mod.PETRIFYRES
    elseif effect == xi.effect.BIND then
        effectres = xi.mod.BINDRES
    elseif effect == xi.effect.CURSE_I or effect == xi.effect.CURSE_II or effect == xi.effect.BANE then
        effectres = xi.mod.CURSERES
    elseif effect == xi.effect.WEIGHT then
        effectres = xi.mod.GRAVITYRES
    elseif effect == xi.effect.SLOW or effect == xi.effect.ELEGY then
        effectres = xi.mod.SLOWRES
    elseif effect == xi.effect.STUN then
        effectres = xi.mod.STUNRES
    elseif effect == xi.effect.CHARM_I or effect == xi.effect.CHARM_II then
        effectres = xi.mod.CHARMRES
    elseif effect == xi.effect.AMNESIA then
        effectres = xi.mod.AMNESIARES
    end

    if effectres ~= 0 then
        return target:getMod(effectres) + statusres
    end

    return statusres
end

-- Returns the bonus magic accuracy for any spell
function getSpellBonusAcc(caster, target, spell, params)
    local magicAccBonus = 0
    local castersWeather = caster:getWeather()
    local skill = spell:getSkillType()
    local spellGroup = spell:getSpellGroup()
    local element = spell:getElement()
    local casterJob = caster:getMainJob()

    if caster:hasStatusEffect(xi.effect.ALTRUISM) and spellGroup == xi.magic.spellGroup.WHITE then
        magicAccBonus = magicAccBonus + caster:getStatusEffect(xi.effect.ALTRUISM):getPower()
    end

    if caster:hasStatusEffect(xi.effect.FOCALIZATION) and spellGroup == xi.magic.spellGroup.BLACK then
        magicAccBonus = magicAccBonus + caster:getStatusEffect(xi.effect.FOCALIZATION):getPower()
    end

    local skillchainTier, skillchainCount = FormMagicBurst(element, target)

    --add acc for skillchains
    if skillchainTier > 0 then
        magicAccBonus = magicAccBonus + 25
    end

    --Add acc for klimaform
    if element > 0 then
        if caster:hasStatusEffect(xi.effect.KLIMAFORM) and (castersWeather == xi.magic.singleWeatherStrong[element] or castersWeather == xi.magic.doubleWeatherStrong[element]) then
            magicAccBonus = magicAccBonus + 15
        end
    end

    if casterJob == xi.job.WHM then
        magicAccBonus = magicAccBonus + caster:getJobPointLevel(xi.jp.WHM_MAGIC_ACC_BONUS)
    end

    if casterJob == xi.job.BLM then
        -- Add MACC for BLM Elemental Magic Merits
        if skill == xi.skill.ELEMENTAL_MAGIC then
            magicAccBonus = magicAccBonus + caster:getMerit(xi.merit.ELEMENTAL_MAGIC_ACCURACY)
        end

        -- BLM Job Point: MACC Bonus +1
        magicAccBonus = magicAccBonus + caster:getJobPointLevel(xi.jp.BLM_MAGIC_ACC_BONUS)

    end

    if casterJob == xi.job.DRK then
        -- Add MACC for Dark Seal
        if skill == xi.skill.DARK_MAGIC and caster:hasStatusEffect(xi.effect.DARK_SEAL) then
            magicAccBonus = magicAccBonus + 256
        end
    end

    if casterJob == xi.job.RDM then
        -- Add MACC for RDM group 1 merits
        if element >= xi.magic.element.FIRE and element <= xi.magic.element.WATER then
            magicAccBonus = magicAccBonus + caster:getMerit(rdmMerit[element])
        end

        -- RDM Job Point: During saboteur, Enfeebling MACC +2
        if skill == xi.skill.ENFEEBLING_MAGIC and caster:hasStatusEffect(xi.effect.SABOTEUR) then
            local jpValue = caster:getJobPointLevel(xi.jp.SABOTEUR_EFFECT)

            magicAccBonus = magicAccBonus + (jpValue * 2)
        end

        -- RDM Job Point: Magic Accuracy Bonus, All MACC + 1
        magicAccBonus = magicAccBonus + caster:getJobPointLevel(xi.jp.RDM_MAGIC_ACC_BONUS)
    end

    if casterJob == xi.job.NIN then
        -- NIN Job Point: Ninjitsu Accuracy Bonus
        if skill == xi.skill.NINJUTSU then
            magicAccBonus = magicAccBonus + caster:getJobPointLevel(xi.jp.NINJITSU_ACC_BONUS)
        end
    end

    if casterJob == xi.job.BLU then
        -- BLU MACC merits - nuke acc is handled in bluemagic.lua
        if skill == xi.skill.BLUE_MAGIC then
            magicAccBonus = magicAccBonus + caster:getMerit(xi.merit.MAGICAL_ACCURACY)
        end
    end

    if casterJob == xi.job.SCH then
        if (spellGroup == xi.magic.spellGroup.WHITE and caster:hasStatusEffect(xi.effect.PARSIMONY)) or
            (spellGroup == xi.magic.spellGroup.BLACK and caster:hasStatusEffect(xi.effect.PENURY))
        then
            local jpValue = caster:getJobPointLevel(xi.jp.STRATEGEM_EFFECT_I)

            magicAccBonus = magicAccBonus + jpValue
        end
    end

    return magicAccBonus
end

function handleAfflatusMisery(caster, spell, dmg)
    if caster:hasStatusEffect(xi.effect.AFFLATUS_MISERY) then
        local misery = caster:getMod(xi.mod.AFFLATUS_MISERY)
        -- According to BGWiki Caps at 300 magic damage.
        local miseryMax = 300

        miseryMax = miseryMax * (1 - caster:getMerit(xi.merit.ANIMUS_MISERY)/100)

        -- BGwiki puts the boost capping at 200% bonus at 1/4th max HP.
        if misery > miseryMax then
            misery = miseryMax
        end

        -- Damage is 2x at boost cap.
        local boost = 1 + (misery / miseryMax)

        dmg = math.floor(dmg * boost)

        -- printf("AFFLATUS MISERY: Damage boosted by %f to %d", boost, dmg)

        --Afflatus Mod is Used Up...
        caster:setMod(xi.mod.AFFLATUS_MISERY, 0)
    end
    return dmg
end

 function finalMagicAdjustments(caster, target, spell, dmg)
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
        -- dmg = utils.takeShadows(target, dmg, 1)

        -- if (dmg == 0) then
            -- spell:setMsg(xi.msg.basic.SHADOW_ABSORB)
            -- return 1
        -- end
    end

    local skill = spell:getSkillType()
    if skill == xi.skill.ELEMENTAL_MAGIC then
        dmg = dmg * ELEMENTAL_POWER
    elseif skill == xi.skill.DARK_MAGIC then
        dmg = dmg * DARK_POWER
    elseif skill == xi.skill.NINJUTSU then
        dmg = dmg * NINJUTSU_POWER
    elseif skill == xi.skill.DIVINE_MAGIC then
        dmg = dmg * DIVINE_POWER
    end

    dmg = target:magicDmgTaken(dmg)

    if dmg > 0 then
        dmg = dmg - target:getMod(xi.mod.PHALANX)
        dmg = utils.clamp(dmg, 0, 99999)
    end

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

function finalMagicNonSpellAdjustments(caster, target, ele, dmg)
    --Handles target's HP adjustment and returns SIGNED dmg (negative values on absorb)

    dmg = target:magicDmgTaken(dmg)

    if dmg > 0 then
        dmg = dmg - target:getMod(xi.mod.PHALANX)
        dmg = utils.clamp(dmg, 0, 99999)
    end

    --handling stoneskin
    dmg = utils.stoneskin(target, dmg)

    dmg = utils.clamp(dmg, -99999, 99999)

    if dmg < 0 then
        dmg = -(target:addHP(-dmg))
    else
        target:takeDamage(dmg, caster, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL + ele)
    end
    --Not updating enmity from damage, as this is primarily used for additional effects (which don't generate emnity)
    -- in the case that updating enmity is needed, do it manually after calling this
    --target:updateEnmityFromDamage(caster, dmg)

    return dmg
end

function adjustForTarget(target, dmg, ele)
    if dmg > 0 and math.random(0, 99) < target:getMod(xi.magic.absorbMod[ele]) then
        return -dmg
    end
    if math.random(0, 99) < target:getMod(nullMod[ele]) then
        return 0
    end
    --Moved non element specific absorb and null mod checks to core
    --TODO: update all lua calls to magicDmgTaken with appropriate element and remove this function
    return dmg
end

function calculateMagicBurst(caster, spell, target, params)

    local burst = 1.0
    local skillchainburst = 1.0
    local modburst = 1.0

    if spell:getSpellGroup() == 3 and not caster:hasStatusEffect(xi.effect.BURST_AFFINITY) then
        return burst
    end

    -- Obtain first multiplier from gear, atma and job traits
    modburst = modburst + (caster:getMod(xi.mod.MAG_BURST_BONUS) / 100) + params.AMIIburstBonus

    if caster:isBehind(target) and caster:hasStatusEffect(xi.effect.INNIN) then
        modburst = modburst + (caster:getMerit(xi.merit.INNIN_EFFECT)/100)
    end

    -- BLM Job Point: Magic Burst Damage
    modburst = modburst + (caster:getJobPointLevel(xi.jp.MAGIC_BURST_DMG_BONUS) / 100)

    -- Cap bonuses from first multiplier at 40% or 1.4
    if modburst > 1.4 then
        modburst = 1.4
    end

    -- Obtain second multiplier from skillchain
    -- Starts at 35% damage bonus, increases by 10% for every additional weaponskill in the chain
    local skillchainTier, skillchainCount = FormMagicBurst(spell:getElement(), target)

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

function addBonuses(caster, spell, target, dmg, params)
    local ele = spell:getElement()
    local affinityBonus = AffinityBonusDmg(caster, ele)
    local magicDefense = getElementalDamageReduction(target, ele)
    local dayWeatherBonus = 1.00
    local weather = caster:getWeather()
    local casterJob = caster:getMainJob()

    params = params or {}
    params.bonusmab = params.bonusmab or 0
    params.AMIIburstBonus = params.AMIIburstBonus or 0

    dmg = math.floor(dmg * affinityBonus)
    dmg = math.floor(dmg * magicDefense)

    if weather == xi.magic.singleWeatherStrong[ele] then
        if caster:getMod(xi.mod.IRIDESCENCE) >= 1 then
            if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 or isHelixSpell(spell) then
                dayWeatherBonus = dayWeatherBonus + 0.10
            end
        end
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 or isHelixSpell(spell) then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif caster:getWeather() == xi.magic.singleWeatherWeak[ele] then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 or isHelixSpell(spell) then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    elseif weather == xi.magic.doubleWeatherStrong[ele] then
        if caster:getMod(xi.mod.IRIDESCENCE) >= 1 then
            if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 or isHelixSpell(spell) then
                dayWeatherBonus = dayWeatherBonus + 0.10
            end
        end
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 or isHelixSpell(spell) then
            dayWeatherBonus = dayWeatherBonus + 0.25
        end
    elseif weather == xi.magic.doubleWeatherWeak[ele] then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 or isHelixSpell(spell) then
            dayWeatherBonus = dayWeatherBonus - 0.25
        end
    end

    local dayElement = VanadielDayElement()
    if dayElement == ele then
        dayWeatherBonus = dayWeatherBonus + caster:getMod(xi.mod.DAY_NUKE_BONUS)/100 -- sorc. tonban(+1)/zodiac ring
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 or isHelixSpell(spell) then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif dayElement == xi.magic.elementDescendant[ele] then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 or isHelixSpell(spell) then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    end

    if dayWeatherBonus > 1.4 then
        dayWeatherBonus = 1.4
    end

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

        local mab_crit = caster:getMod(xi.mod.MAGIC_CRITHITRATE)
        if math.random(1, 100) < mab_crit then
           mab = mab + ( 10 + caster:getMod(xi.mod.MAGIC_CRIT_DMG_INCREASE ) )
        end

        local mdefBarBonus = 0
        if ele >= xi.magic.element.FIRE and ele <= xi.magic.element.WATER then
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

    if mabbonus < 0 then
        mabbonus = 0
    end

    dmg = math.floor(dmg * mabbonus)

    if caster:hasStatusEffect(xi.effect.EBULLIENCE) then
        dmg = dmg * (1.2 + caster:getMod(xi.mod.EBULLIENCE_AMOUNT)/100)
        caster:delStatusEffectSilent(xi.effect.EBULLIENCE)
    end

    dmg = math.floor(dmg)

    return dmg
end

function addBonusesAbility(caster, ele, target, dmg, params)

    local affinityBonus = AffinityBonusDmg(caster, ele)
    dmg = math.floor(dmg * affinityBonus)

    local magicDefense = getElementalDamageReduction(target, ele)
    dmg = math.floor(dmg * magicDefense)

    local dayWeatherBonus = 1.00
    local weather = caster:getWeather()

    if weather == xi.magic.singleWeatherStrong[ele] then
        if caster:getMod(xi.mod.IRIDESCENCE) >= 1 then
            if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
                dayWeatherBonus = dayWeatherBonus + 0.10
            end
        end
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif caster:getWeather() == xi.magic.singleWeatherWeak[ele] then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    elseif weather == xi.magic.doubleWeatherStrong[ele] then
        if caster:getMod(xi.mod.IRIDESCENCE) >= 1 then
            if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
                dayWeatherBonus = dayWeatherBonus + 0.10
            end
        end
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.25
        end
    elseif weather == xi.magic.doubleWeatherWeak[ele] then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus - 0.25
        end
    end

    local dayElement = VanadielDayElement()
    if dayElement == ele then
        dayWeatherBonus = dayWeatherBonus + caster:getMod(xi.mod.DAY_NUKE_BONUS)/100 -- sorc. tonban(+1)/zodiac ring
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif dayElement == xi.magic.elementDescendant[ele] then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    end

    if dayWeatherBonus > 1.4 then
        dayWeatherBonus = 1.4
    end

    dmg = math.floor(dmg * dayWeatherBonus)

    local mab = 1
    local mdefBarBonus = 0
    if
        ele >= xi.magic.element.FIRE and
        ele <= xi.magic.element.WATER and
        target:hasStatusEffect(xi.magic.barSpell[ele])
    then -- bar- spell magic defense bonus
        mdefBarBonus = target:getStatusEffect(xi.magic.barSpell[ele]):getSubPower()
    end

    if params ~= nil and params.bonusmab ~= nil and params.includemab == true then
        mab = (100 + caster:getMod(xi.mod.MATT) + params.bonusmab) / (100 + target:getMod(xi.mod.MDEF) + mdefBarBonus)
    elseif params == nil or (params ~= nil and params.includemab == true) then
        mab = (100 + caster:getMod(xi.mod.MATT)) / (100 + target:getMod(xi.mod.MDEF) + mdefBarBonus)
    end

    if mab < 0 then
        mab = 0
    end

    dmg = math.floor(dmg * mab)

    -- print(affinityBonus)
    -- print(speciesReduction)
    -- print(dayWeatherBonus)
    -- print(burst)
    -- print(mab)
    -- print(magicDmgMod)

    return dmg
end

-- get elemental damage reduction
function getElementalDamageReduction(target, element)
    local defense = 1
    if element > 0 then
        defense = 1 - (target:getMod(xi.magic.defenseMod[element]) / 256)

        return utils.clamp(defense, 0.0, 2.0)
    end

    return defense
end

-----------------------------------
--  Elemental Debuff Potency functions
-----------------------------------

function getElementalDebuffDOT(INT)
    local DOT = 0
    if INT<= 39 then
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

function getElementalDebuffStatDownFromDOT(dot)
    local stat_down = 0
    stat_down = (dot-1)*2 +5
    return stat_down
end

function getHelixDuration(caster)
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

function isHelixSpell(spell)
    --Dark Arts will further increase Helix duration, but testing is ongoing.

    local id = spell:getID()
    if id >= 278 and id <= 285 then
        return true
    end
    return false
end

function handleThrenody(caster, target, spell, basePower, baseDuration, modifier)
    -- Process resitances
    local staff = AffinityBonusAcc(caster, spell:getElement())
    -- print("staff=" .. staff)
    local dCHR = (caster:getStat(xi.mod.CHR) - target:getStat(xi.mod.CHR))
    -- print("dCHR=" .. dCHR)
    local params = {}
    params.attribute = xi.mod.CHR
    params.skillType = xi.skill.SINGING
    params.bonus = staff

    local resm = applyResistance(caster, target, spell, params)
    -- print("rsem=" .. resm)

    if resm < 0.5 then
        -- print("resm resist")
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        return xi.effect.THRENODY
    end

    -- Remove previous Threnody
    target:delStatusEffect(xi.effect.THRENODY)

    local iBoost = caster:getMod(xi.mod.THRENODY_EFFECT) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)
    local power = basePower + iBoost*5
    local duration = baseDuration * ((iBoost * 0.1) + (caster:getMod(xi.mod.SONG_DURATION_BONUS)/100) + 1)

    if caster:hasStatusEffect(xi.effect.SOUL_VOICE) then
        power = power * 2
    elseif caster:hasStatusEffect(xi.effect.MARCATO) then
        power = power * 1.5
    end

    if caster:hasStatusEffect(xi.effect.TROUBADOUR) then
        duration = duration * 2
    end

    -- Set spell message and apply status effect
    target:addStatusEffect(xi.effect.THRENODY, -power, 0, duration, 0, modifier, 0)

    return xi.effect.THRENODY
end

function handleNinjutsuDebuff(caster, target, spell, basePower, baseDuration, modifier)
    -- Add new
    target:addStatusEffectEx(xi.effect.NINJUTSU_ELE_DEBUFF, 0, basePower, 0, baseDuration, 0, modifier, 0)
    return xi.effect.NINJUTSU_ELE_DEBUFF
end

-- Returns true if you can overwrite the effect
-- Example: canOverwrite(target, xi.effect.SLOW, 25)
function canOverwrite(target, effect, power, mod)
    mod = mod or 1

    local statusEffect = target:getStatusEffect(effect)

    -- effect not found so overwrite
    if statusEffect == nil then
        return true
    end

    -- overwrite if its weaker
    if statusEffect:getPower()*mod > power then
        return false
    end

    return true
end

function doElementalNuke(caster, spell, target, spellParams)
    local DMG = 0
    local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local V = 0
    local M = 0

    if USE_OLD_MAGIC_DAMAGE and spellParams.V ~= nil and spellParams.M ~= nil then
        V = spellParams.V -- Base value
        M = spellParams.M -- Tier multiplier
        local I = spellParams.I -- Inflection point
        local cap = I * 2 + V -- Base damage soft cap

        if dINT < 0 then
            -- If dINT is a negative value the tier multiplier is always 1
            DMG = V + dINT

            -- Check/ set lower limit of 0 damage for negative dINT
            if DMG < 1 then
                return 0
            end

        elseif dINT < I then
             -- If dINT > 0 but below inflection point I
            DMG = V + dINT * M

        else
             -- Above inflection point I additional dINT is only half as effective
            DMG = V + I + ((dINT - I) * (M / 2))
        end

        -- Check/ set damage soft cap
        if DMG > cap then
            DMG = cap
        end

    else
        local hasMultipleTargetReduction = spellParams.hasMultipleTargetReduction --still unused!!!
        local resistBonus = spellParams.resistBonus
        local mDMG = caster:getMod(xi.mod.MAGIC_DAMAGE)

        -- BLM Job Point: Manafont Elemental Magic Damage +3
        if caster:hasStatusEffect(xi.effect.MANAFONT) then
            mDMG = mDMG + (caster:getJobPointLevel(xi.jp.MANAFONT_EFFECT) * 3)
        end

        -- BLM Job Point: With Manawell mDMG +1
        if caster:hasStatusEffect(xi.effect.MANAWELL) then
            mDMG = mDMG + caster:getJobPointLevel(xi.jp.MANAWELL_EFFECT)
            caster:delStatusEffectSilent(xi.effect.MANAWELL)
        end

        -- BLM Job Point: Magic Damage Bonus
        mDMG = mDMG + caster:getJobPointLevel(xi.jp.MAGIC_DMG_BONUS)

        --[[
                Calculate base damage:
                D = mDMG + V + (dINT × M)
                D is then floored
                For dINT reduce by amount factored into the V value (example: at 134 INT, when using V100 in the calculation, use dINT = 134-100 = 34)
        ]]

        if dINT <= 49 then
            V = spellParams.V0
            M = spellParams.M0
            DMG = math.floor(DMG + mDMG + V + (dINT * M))

            if DMG <= 0 then
                return 0
            end

        elseif dINT >= 50 and dINT <= 99 then
            V = spellParams.V50
            M = spellParams.M50
            DMG = math.floor(DMG + mDMG + V + ((dINT - 50) * M))

        elseif dINT >= 100 and dINT <= 199 then
            V = spellParams.V100
            M = spellParams.M100
            DMG = math.floor(DMG + mDMG + V + ((dINT - 100) * M))

        elseif dINT > 199 then
            V = spellParams.V200
            M = spellParams.M200
            DMG = math.floor(DMG + mDMG + V + ((dINT - 200) * M))
        end
    end

    --get resist multiplier (1x if no resist)
    local params = {}
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.ELEMENTAL_MAGIC
    params.resistBonus = resistBonus

    local resist = applyResistance(caster, target, spell, params)

    --get the resisted damage
    DMG = DMG * resist

    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    DMG = addBonuses(caster, spell, target, DMG, spellParams)

    --add in target adjustment
    local ele = spell:getElement()
    DMG = adjustForTarget(target, DMG, ele)

    --add in final adjustments
    DMG = finalMagicAdjustments(caster, target, spell, DMG)

    return DMG
end

function doDivineNuke(caster, target, spell, params)
    params.skillType = xi.skill.DIVINE_MAGIC
    params.attribute = xi.mod.MND

    return doNuke(caster, target, spell, params)
end

function doNinjutsuNuke(caster, target, spell, params)
    local mabBonus = params.bonusmab

    mabBonus = mabBonus or 0

    mabBonus = mabBonus + caster:getMod(xi.mod.NIN_NUKE_BONUS) -- "enhances ninjutsu damage" bonus
    if caster:hasStatusEffect(xi.effect.INNIN) and caster:isBehind(target, 23) then -- Innin mag atk bonus from behind, guesstimating angle at 23 degrees
        mabBonus = mabBonus + caster:getStatusEffect(xi.effect.INNIN):getPower()
    end
    params.skillType = xi.skill.NINJUTSU
    params.attribute = xi.mod.INT
    params.bonusmab = mabBonus

    return doNuke(caster, target, spell, params)
end

function doNuke(caster, target, spell, params)
    --calculate raw damage
    local dmg = calculateMagicDamage(caster, target, spell, params)
    --get resist multiplier (1x if no resist)
    local resist = applyResistance(caster, target, spell, params)
    --get the resisted damage
    dmg = dmg*resist
    if skill == xi.skill.NINJUTSU then
        if caster:getMainJob() == xi.job.NIN then -- NIN main gets a bonus to their ninjutsu nukes
            local ninSkillBonus = 100
            if spell:getID() % 3 == 2 then -- ichi nuke spell ids are 320, 323, 326, 329, 332, and 335
                ninSkillBonus = 100 + math.floor((caster:getSkillLevel(xi.skill.NINJUTSU) - 50)/2) -- getSkillLevel includes bonuses from merits and modifiers (ie. gear)
            elseif spell:getID() % 3 == 0 then -- ni nuke spell ids are 1 more than their corresponding ichi spell
                ninSkillBonus = 100 + math.floor((caster:getSkillLevel(xi.skill.NINJUTSU) - 125)/2)
            else -- san nuke spell, also has ids 1 more than their corresponding ni spell
                ninSkillBonus = 100 + math.floor((caster:getSkillLevel(xi.skill.NINJUTSU) - 275)/2)
            end

            ninSkillBonus = utils.clamp(ninSkillBonus, 100, 200) -- bonus caps at +100%, and does not go negative
            dmg = dmg + (caster:getJobPointLevel(xi.jp.ELEM_NINJITSU_EFFECT) * 2)
            dmg = dmg * ninSkillBonus/100
        end
        -- boost with Futae
        if caster:hasStatusEffect(xi.effect.FUTAE) then
            dmg = dmg + (caster:getJobPointLevel(xi.jp.FUTAE_EFFECT) * 5)
            dmg = math.floor(dmg * 1.50)
            caster:delStatusEffect(xi.effect.FUTAE)
        end
    end

    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg, params)
    --add in target adjustment
    dmg = adjustForTarget(target, dmg, spell:getElement())
    --add in final adjustments
    dmg = finalMagicAdjustments(caster, target, spell, dmg)
    return dmg
end

function doDivineBanishNuke(caster, target, spell, params)
    params.skillType = xi.skill.DIVINE_MAGIC
    params.attribute = xi.mod.MND

    --calculate raw damage
    local dmg = calculateMagicDamage(caster, target, spell, params)
    --get resist multiplier (1x if no resist)
    local resist = applyResistance(caster, target, spell, params)
    --get the resisted damage
    dmg = dmg*resist

    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg, params)
    --add in target adjustment
    dmg = adjustForTarget(target, dmg, spell:getElement())
    --handling afflatus misery
    dmg = handleAfflatusMisery(caster, spell, dmg)
    --add in final adjustments
    dmg = finalMagicAdjustments(caster, target, spell, dmg)
    return dmg
end

function calculateDurationForLvl(duration, spellLvl, targetLvl)
    if targetLvl < spellLvl then
        return duration * targetLvl / spellLvl
    end

    return duration
end

function calculateDuration(duration, magicSkill, spellGroup, caster, target, useComposure)
    local casterJob = caster:getMainJob()

    if magicSkill == xi.skill.ENHANCING_MAGIC then -- Enhancing Magic
        -- Gear mods
        duration = duration + duration * caster:getMod(xi.mod.ENH_MAGIC_DURATION) / 100

        -- prior according to bg-wiki
        if casterJob == xi.job.RDM then
            duration = duration + caster:getMerit(xi.merit.ENHANCING_MAGIC_DURATION) + caster:getJobPointLevel(xi.jp.ENHANCING_DURATION)
        end

        -- Default is true
        useComposure = useComposure or (useComposure == nill and true)

        -- Composure
        if useComposure and caster:hasStatusEffect(xi.effect.COMPOSURE) and caster:getID() == target:getID() then
            duration = duration * 3
        end

        -- Perpetuance
        if caster:hasStatusEffect(xi.effect.PERPETUANCE) and spellGroup == xi.magic.spellGroup.WHITE then
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
            if caster:hasStatusEffect(xi.effect.STYMIE) and target:canGainStatusEffect(effect) then
                duration = duration + caster:getJobPointLevel(xi.jp.STYMIE_EFFECT)
            end
        end
    end

    return math.floor(duration)
end

function calculatePotency(basePotency, magicSkill, caster, target)
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

-- Output magic hit rate for all levels
function outputMagicHitRateInfo()
    for casterLvl = 1, 75 do

        printf("")
        printf("-------- CasterLvl: %d", casterLvl)

        for lvlMod = -5, 20 do

            local targetLvl = casterLvl + lvlMod

            if targetLvl >= 0 then
                -- assume BLM spell, A+
                local magicAcc = utils.getSkillLvl(6, casterLvl)
                -- assume default monster magic eva, D
                local magicEvaRank = 3
                local rate = 0

                local magicEva = utils.getMobSkillLvl(magicEvaRank, targetLvl)

                local dINT = (lvlMod + 1) * -1

                if dINT > 10 then
                    magicAcc = magicAcc + 10 + (dINT - 10)/2
                else
                    magicAcc = magicAcc + dINT
                end

                local magicHitRate = calculateMagicHitRate(magicAcc, magicEva, 0, casterLvl, targetLvl)

                printf("Lvl: %d vs %d, %d%%, MA: %d, ME: %d", casterLvl, targetLvl, magicHitRate, magicAcc, magicEva)
            end

        end
    end
end

xi.ma = xi.magic
