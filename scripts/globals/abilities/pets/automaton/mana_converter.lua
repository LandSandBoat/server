-----------------------------------
-- Mana Converter
-----------------------------------
require("scripts/globals/automatonweaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 180)
    local hp = target:getHP()
    local duration = 30
    local amount = math.floor((hp / 2) / 10)
    local difference = math.ceil(hp / 2 - (amount * 10))
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)

    target:addMP(difference) -- To prevent possible loss of MP from flooring the refresh
    target:setHP(math.floor(hp / 2))
    target:delStatusEffect(xi.effect.REFRESH)
    target:addStatusEffect(xi.effect.REFRESH, amount, 3, duration)

    return xi.effect.REFRESH
end

return abilityObject
