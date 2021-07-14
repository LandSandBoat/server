-----------------------------------
-- Provoke
-----------------------------------
require("scripts/globals/automatonweaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAutomatonSkillCheck = function(target, automaton, skill)
    return 0
end

ability_object.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 30)
    target:addEnmity(automaton, 1, 1800)
    skill:setMsg(xi.msg.basic.USES)
    return 0
end

return ability_object
