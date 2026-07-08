-----------------------------------
-- Provoke - Goads the target into attacking the automaton.
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 30)
    target:addEnmity(automaton, 1, 1800) -- Confirmed on retail.

    skill:setMsg(xi.msg.basic.PROVOKE_SWITCH)
    return 0
end

return abilityObject
