-----------------------------------
-- Flashbulb
-- Applies "Flash" to the target.
-- https://wiki.ffo.jp/html/6295.html
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 45)

    skill:setMsg(xi.mobskills.mobStatusEffectMove(automaton, target, xi.effect.FLASH, 0, 0, 12))

    return xi.effect.FLASH
end

return abilityObject
