-----------------------------------
-- Automaton Utility Module
-----------------------------------
-- https://wiki.ffo.jp/html/19739.html
-- https://wiki.ffo.jp/html/32936.html
-----------------------------------
require('modules/module_utils')
require('scripts/globals/automaton')
require('scripts/globals/pets/automaton')
-----------------------------------
local moduleName = 'automaton_global'

if not xi.module.isContentEnabled('WOTG') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

local maneuverList =
{
    [xi.jobAbility.FIRE_MANEUVER   ] = { effect = xi.effect.FIRE_MANEUVER,    element = xi.element.FIRE,    stat = xi.mod.STR },
    [xi.jobAbility.ICE_MANEUVER    ] = { effect = xi.effect.ICE_MANEUVER,     element = xi.element.ICE,     stat = xi.mod.INT },
    [xi.jobAbility.WIND_MANEUVER   ] = { effect = xi.effect.WIND_MANEUVER,    element = xi.element.WIND,    stat = xi.mod.AGI },
    [xi.jobAbility.EARTH_MANEUVER  ] = { effect = xi.effect.EARTH_MANEUVER,   element = xi.element.EARTH,   stat = xi.mod.VIT },
    [xi.jobAbility.THUNDER_MANEUVER] = { effect = xi.effect.THUNDER_MANEUVER, element = xi.element.THUNDER, stat = xi.mod.DEX },
    [xi.jobAbility.WATER_MANEUVER  ] = { effect = xi.effect.WATER_MANEUVER,   element = xi.element.WATER,   stat = xi.mod.MND },
    [xi.jobAbility.LIGHT_MANEUVER  ] = { effect = xi.effect.LIGHT_MANEUVER,   element = xi.element.LIGHT,   stat = xi.mod.CHR },
    [xi.jobAbility.DARK_MANEUVER   ] = { effect = xi.effect.DARK_MANEUVER,    element = xi.element.DARK,    stat = nil        },
}

local function getAddBurdenValue(player, maneuverElement, maneuverStat)
    -- Dark Maneuvers
    if maneuverElement == xi.element.DARK then
        local frameEquipped = player:getAutomatonFrame()

        if
            frameEquipped == xi.automaton.frame.VALOREDGE or
            frameEquipped == xi.automaton.frame.SHARPSHOT
        then
            return 8
        end

        return 14
    else
        -- Fire, Ice, Wind, Earth, Lightning, Water, Light Maneuvers
        local statDifference = player:getStat(maneuverStat) - player:getPet():getStat(maneuverStat)

        if statDifference >= 4 then
            return 14
        elseif statDifference >= 0 then
            return 19 - statDifference
        else
            return 20
        end
    end
end

-- Remove Overdrive returning 3 maneuvers while active.
m:addOverride('xi.automaton.getManeuverCount', function(master, maneuvers)
    if not master then
        return 0
    end

    return math.min(maneuvers, 3)
end)

-- Remove level scaling maneuver stat bonus.
m:addOverride('xi.automaton.onUseManeuver', function(player, target, ability, action)
    local pet = player:getPet()

    if not pet then
        return
    end

    local maneuverInfo = maneuverList[ability:getID()]
    local element      = maneuverInfo.element - 1
    local burdenValue  = getAddBurdenValue(player, maneuverInfo.element, maneuverInfo.stat)
    local overload     = target:addBurden(element, burdenValue)

    if
        overload ~= 0 and
        (player:getMod(xi.mod.PREVENT_OVERLOAD) > 0 or pet:getMod(xi.mod.PREVENT_OVERLOAD) > 0) and
        player:delStatusEffectSilent(xi.effect.WATER_MANEUVER)
    then
        overload = 0
    end

    action:messageID(player:getID(), xi.msg.basic.AUTO_OVERLOAD_CHANCE)

    if overload ~= 0 then
        target:removeAllManeuvers()
        target:addStatusEffect(xi.effect.OVERLOAD, { duration = overload, origin = player })
        pet:addStatusEffect(xi.effect.OVERLOAD, { duration = overload, origin = pet })
        action:messageID(player:getID(), xi.msg.basic.AUTO_OVERLOADED)
    else
        if target:getActiveManeuverCount() == 3 then
            target:removeOldestManeuver()
        end

        local maneuverBonus = 1 + target:getMod(xi.mod.MANEUVER_BONUS)

        target:addStatusEffect(maneuverInfo.effect, { power = maneuverBonus, duration = utils.clamp(pet:getLocalVar('MANEUVER_DURATION'), 60, 300), origin = player })
    end

    return target:getOverloadChance(element)
end)

return m
