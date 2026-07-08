-----------------------------------
-- Mighty Strikes (Automaton)
-- TODO: Implement JP Bonuses
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    xi.mobskills.mobBuffMove(target, xi.effect.MIGHTY_STRIKES, 1, 0, 45)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.MIGHTY_STRIKES
end

return abilityObject
