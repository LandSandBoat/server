-----------------------------------
-- Provoke
-----------------------------------
require("scripts/globals/automatonweaponskills")
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 30)
    target:addEnmity(automaton, 1, 1800)
    skill:setMsg(xi.msg.basic.PROVOKE_SWITCH, target)
    return 0
end

return abilityObject
