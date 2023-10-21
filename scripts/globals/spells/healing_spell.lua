-----------------------------------
-- Healing Spell
-- Used for spells that heal directly.
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/magicburst")
require("scripts/globals/utils")
require("scripts/globals/magic")
-----------------------------------
xi = xi or {}
xi.spells = xi.spells or {}
xi.spells.healing = xi.spells.healing or {}

xi.spells.healing.healingTable =
{
    [xi.magic.spell.CURE]           = { { power = 60, maxCap = 20, rate = 1, constant = -10, minCap = 10 }, { power = 100, maxCap = 30, rate = 2, constant = 5, minCap = 10 }, { power = 999, maxCap = 30, rate = 57, constant = 29.125, minCap = 10 } },
    [xi.magic.spell.CURE_II]        = { { power = 110, maxCap = 75, rate = 1, constant = 20, minCap = 60 }, { power = 170, maxCap = 90, rate = 2, constant = 47.5, minCap = 60 }, { power = 999, maxCap = 90, rate = 35.6666, constant = 87.62, minCap = 60 } },
    [xi.magic.spell.CURE_III]       = { { power = 180, maxCap = 160, rate = 1, constant = 70, minCap = 130 }, { power = 300, maxCap = 190, rate = 2, constant = 115, minCap = 130 }, { power = 999, maxCap = 190, rate = 15.6666, constant = 180.43, minCap = 130 } },
    [xi.magic.spell.CURE_IV]        = { { power = 220, maxCap = 330, rate = 0.6666, constant = 165, minCap = 270 }, { power = 460, maxCap = 390, rate = 2, constant = 275, minCap = 270 }, { power = 999, maxCap = 390, rate = 6.5, constant = 354.6666, minCap = 270 } },
    [xi.magic.spell.CURE_V]         = { { power = 320, maxCap = 570, rate = 0.6666, constant = 330, minCap = 450 }, { power = 560, maxCap = 690, rate = 1, constant = 410, minCap = 450 }, { power = 999, maxCap = 690, rate = 2.8333, constant = 591.2, minCap = 450 } },
    [xi.magic.spell.CURAGA]         = { { power = 110, maxCap = 75, rate = 1, constant = 20, minCap = 60 }, { power = 170, maxCap = 90, rate = 2, constant = 47.5, minCap = 60 }, { power = 999, maxCap = 90, rate = 35.6666, constant = 87.62, minCap = 60 } },
    [xi.magic.spell.CURAGA_II]      = { { power = 180, maxCap = 160, rate = 1, constant = 70, minCap = 130 }, { power = 300, maxCap = 190, rate = 2, constant = 115, minCap = 130 }, { power = 999, maxCap = 190, rate = 15.6666, constant = 180.43, minCap = 130 } },
    [xi.magic.spell.CURAGA_III]     = { { power = 220, maxCap = 330, rate = 0.6666, constant = 165, minCap = 270 }, { power = 460, maxCap = 390, rate = 2, constant = 275, minCap = 270 }, { power = 999, maxCap = 390, rate = 6.5, constant = 354.6666, minCap = 270 } },
    [xi.magic.spell.CURAGA_IV]      = { { power = 320, maxCap = 570, rate = 0.6666, constant = 330, minCap = 450 }, { power = 560, maxCap = 690, rate = 1, constant = 410, minCap = 450 }, { power = 999, maxCap = 690, rate = 2.8333, constant = 591.2, minCap = 450 } },
    [xi.magic.spell.POLLEN]         = { { power = 60, maxCap = 24, rate = 1, constant = -6, minCap = 14 }, { power = 100, maxCap = 24, rate = 2, constant = 9, minCap = 14 }, { power = 999, maxCap = 34, rate = 57, constant = 33.125, minCap = 14 } },
    [xi.magic.spell.HEALING_BREEZE] = { { power = 220, maxCap = 120, rate = 0.6666, constant = -45, minCap = 60 }, { power = 460, maxCap = 120, rate = 2, constant = 65, minCap = 60 }, { power = 999, maxCap = 180, rate = 6.5, constant = 144.6666, minCap = 60 } },
    [xi.magic.spell.WILD_CARROT]    = { { power = 180, maxCap = 150, rate = 1, constant = 60, minCap = 120 }, { power = 300, maxCap = 150, rate = 2, constant = 105, minCap = 120 }, { power = 999, maxCap = 180, rate = 15.6666, constant = 170.43, minCap = 120 } },
    [xi.magic.spell.MAGIC_FRUIT]    = { { power = 320, maxCap = 370, rate = 0.6666, constant = 130, minCap = 250 }, { power = 560, maxCap = 370, rate = 1, constant = 210, minCap = 250 }, { power = 999, maxCap = 490, rate = 2.8333, constant = 391.2, minCap = 250 } },
    [xi.magic.spell.EXUVIATION]     = { { power = 60, maxCap = 70, rate = 1, constant = 40, minCap = 60 }, { power = 100, maxCap = 70, rate = 2, constant = 55, minCap = 60 }, { power = 999, maxCap = 80, rate = 57, constant = 79.125, minCap = 60 } },
}

xi.spells.healing.calculatePower = function(player)
    if player then
        return 3 * player:getStat(xi.mod.MND) + player:getStat(xi.mod.VIT) +
            3 * (math.floor(player:getSkillLevel(xi.skill.HEALING_MAGIC) / 5))
    end

    return 0
end

xi.spells.healing.getHealTable = function(power, spellId)
    if xi.spells.healing.healingTable[spellId] then
        for _, healTable in pairs(xi.spells.healing.healingTable[spellId]) do
            if power < healTable.power then
                return healTable
            end
        end
    end

    return { potencyCap = 0, rate = 0, constant = 0, minCap = 0, maxCap = 0 }
end

xi.spells.healing.handleDayWeatherBonus = function(caster, bonus, element, chance)
    local dwbonus = 1 + bonus
    local dayElement = VanadielDayElement()
    local dbonus = 0
    dbonus = utils.ternary(dayElement == element and chance, 0.10, dbonus)
    dbonus = utils.ternary(dbonus == 0 and dayElement == xi.magic.elementDescendant[element] and chance, -0.10, dbonus)

    return math.min(dwbonus + dbonus, 1.35)
end

xi.spells.healing.getDayWeatherBonus = function(caster, element)
    local weatherBonus         = 0
    local castersWeather       = caster:getWeather()
    local dayWeatherBonusCheck = math.random() < 0.33 or caster:getMod(xi.magic.elementalObi[element]) >= 1 or
        caster:getMod(xi.mod.IRIDESCENCE) >= 1

    if dayWeatherBonusCheck then
        if castersWeather == xi.magic.singleWeatherStrong[element] then
            weatherBonus = 0.10
        elseif castersWeather == xi.magic.singleWeatherWeak[element] then
            weatherBonus = -0.10
        elseif castersWeather == xi.magic.doubleWeatherStrong[element] then
            weatherBonus = 0.25
        elseif castersWeather == xi.magic.doubleWeatherWeak[element] then
            weatherBonus = -0.25
        end
    end

    return xi.spells.healing.handleDayWeatherBonus(caster, weatherBonus, element, dayWeatherBonusCheck)
end

xi.spells.healing.getEquipBonuses = function(caster)
    return math.min(
        1 + (math.min(caster:getMod(xi.mod.CURE_POTENCY), 50) / 100) +
        (math.min(caster:getMod(xi.mod.CURE_POTENCY_II), 30) / 100) + caster:getMod(xi.mod.CURE_POTENCY_BONUS), 1.60)
end

xi.spells.healing.getAbilityBonus = function(caster, isWhiteMagic)
    local bonus = 1

    if caster:hasStatusEffect(xi.effect.RAPTURE) and isWhiteMagic then
        bonus = bonus * (1.5 + caster:getMod(xi.mod.RAPTURE_AMOUNT) / 100)
        caster:delStatusEffect(xi.effect.RAPTURE)
    end

    return utils.ternary(caster:hasStatusEffect(xi.effect.DIVINE_SEAL), bonus * 2, bonus)
end

xi.spells.healing.handleAfflatusSolace = function(caster, target, final)
    if
        caster:isPC() and
        caster:hasStatusEffect(xi.effect.AFFLATUS_SOLACE) and
        not target:hasStatusEffect(xi.effect.STONESKIN)
    then
        local bonuses =
        {
            [11186] = 0.30,
            [11086] = 0.35
        }
        local body = caster:getEquipID(xi.slot.BODY)
        local stoneskin = math.floor((final * utils.ternary(bonuses[body], bonuses[body], 0.25)) * 1 +
        caster:getMerit(xi.merit.ANIMUS_SOLACE) / 100)

        target:addStatusEffect(xi.effect.STONESKIN, stoneskin, 0, 25, 0, 0, 1)
    end
end

xi.spells.healing.applyCasterBonuses = function(caster, final, element, isWhiteMagic)
    local equipBonuses = xi.spells.healing.getEquipBonuses(caster)
    local dwBonus = xi.spells.healing.getDayWeatherBonus(caster, element)
    local abilityBonus = xi.spells.healing.getAbilityBonus(caster, isWhiteMagic)
    return math.floor(((final * equipBonuses) * dwBonus) * abilityBonus)
end

xi.spells.healing.doHealingSpell = function(caster, target, spell, isWhiteMagic)
    local final        = 0
    local spellId      = spell:getID()
    local power        = xi.spells.healing.calculatePower(caster)
    local healingTable = xi.spells.healing.getHealTable(power, spellId)
    local base         = (math.floor(power / 2) / healingTable.rate) + healingTable.constant
    local healingspell = true

    -- Clamp on base instead of maxCap. Power can create over-cure
    base               = utils.clamp(base, 0, base)

    -- special case where healing spells should have no effect
    if target:getMod(xi.mod.CURE_POTENCY_RCVD) == -100 then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return 0
    end

    if xi.magic.isValidHealTarget(caster, target) then
        final = xi.spells.healing.applyCasterBonuses(caster, base, spell:getElement(), isWhiteMagic)
        final = (final * (1.0 + target:getMod(xi.mod.CURE_POTENCY_RCVD) / 100)) * xi.settings.main.CURE_POWER
        xi.spells.healing.handleAfflatusSolace(caster, target, final)
    else
        if target:isUndead() then
            healingspell = false
            spell:setMsg(xi.msg.basic.MAGIC_DMG)
            local params =
            {
                dmg = healingTable.minCap,
                multiplier = 1,
                skillType = xi.skill.HEALING_MAGIC,
                attribute = xi.mod.MND,
                hasMultipleTargetReduction = false,
                diff = caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND),
                bonus = 1.0,
                damageSpell = true,
            }

            local resist = xi.magic.applyResistance(caster, target, spell, params)

            final = (xi.magic.calculateMagicDamage(caster, target, spell, params) * 0.5) * resist
            final = xi.magic.addBonuses(caster, spell, target, final)
            final = xi.magic.adjustForTarget(target, final, spell:getElement())
            final = xi.magic.finalMagicAdjustments(caster, target, spell, final)

            target:takeDamage(final, caster, xi.attackType.MAGICAL, xi.damageType.LIGHT)
            target:updateEnmityFromDamage(caster, final)
        elseif caster:getObjType() == xi.objType.PC then
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        else
            if caster:isMob() and target:isMob() then
                final = xi.spells.healing.applyCasterBonuses(caster, base, spell:getElement(), isWhiteMagic)
                final = (final * (1.0 + target:getMod(xi.mod.CURE_POTENCY_RCVD) / 100)) * xi.settings.main.CURE_POWER
            end
        end
    end

    if healingspell then
        final = math.min(final, target:getMaxHP() - target:getHP())
        target:addHP(final)

        if target:getID() == spell:getPrimaryTargetID() then
            spell:setMsg(xi.msg.basic.MAGIC_RECOVERS_HP)
        else
            spell:setMsg(xi.msg.basic.SELF_HEAL_SECONDARY)
        end
    end

    local curetomp = (final * caster:getMod(xi.mod.CURE2MP_PERCENT)) / 100

    if curetomp > 0 then
        caster:addMP(curetomp)
    end

    -- Add enmity from cures. Cure V enmity is a set value defined spell_list.sql
    if caster:isPC() and spellId ~= xi.magic.spell.CURE_V then
        caster:updateEnmityFromCure(target, final)
    end

    return final
end
