-----------------------------------
-- Mana Converter
-- Converts HP to MP. The amount of MP restored is based on the amount of HP lost.
-- MP is restored over 30 seconds in the form of a Refresh effect.
-- https://wiki.ffo.jp/html/5329.html
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 180)

    local currentHP = target:getHP()
    local hpCost = math.floor(currentHP / 2)
    local refreshAmount = math.floor(hpCost / 10)

    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)

    target:setHP(currentHP - hpCost)

    target:delStatusEffect(xi.effect.REFRESH)
    target:addStatusEffect(xi.effect.REFRESH, { power = refreshAmount, duration = 30, origin = automaton, tick = 3 })

    return xi.effect.REFRESH
end

return abilityObject
