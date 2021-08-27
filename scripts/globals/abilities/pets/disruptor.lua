-----------------------------------
-- Disruptor
-----------------------------------
require("scripts/globals/automatonweaponskills")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onMobSkillCheck = function(target, automaton, skill)
    return 0
end

ability_object.onPetAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 60)
    local effect = target:dispelStatusEffect()
    if effect ~= xi.effect.NONE then
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return effect
end

return ability_object
