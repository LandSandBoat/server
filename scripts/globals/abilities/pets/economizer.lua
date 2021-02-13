-----------------------------------
-- Economizer
-----------------------------------
require("scripts/globals/automatonweaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

function onMobSkillCheck(target, automaton, skill)
    return 0
end

ability_object.onPetAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(tpz.recast.ABILITY, skill:getID(), 180)
    local maneuvers = master:countEffect(tpz.effect.DARK_MANEUVER)
    local amount = math.floor(automaton:getMaxMP() * 0.2 * maneuvers)
    skill:setMsg(tpz.msg.basic.SKILL_RECOVERS_MP)

    for i = 1, maneuvers do
        master:delStatusEffectSilent(tpz.effect.DARK_MANEUVER)
    end

    return automaton:addMP(amount)
end

return ability_object
