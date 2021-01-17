---------------------------------------------
-- Replicator
---------------------------------------------
require("scripts/globals/automatonweaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------
local ability_object = {}

function onMobSkillCheck(target, automaton, skill)
    return 0
end

ability_object.onPetAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(tpz.recast.ABILITY, skill:getID(), 60)
    local maneuvers = master:countEffect(tpz.effect.WIND_MANEUVER)
    local duration = 300
    local shadows = 1 + maneuvers -- math.floor(maneuvers * 3.5) currently on retail

    if target:addStatusEffect(tpz.effect.BLINK, shadows, 0, duration) then
        skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)
        for i = 1, maneuvers do
            master:delStatusEffectSilent(tpz.effect.WIND_MANEUVER)
        end
    else
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    end

    return tpz.effect.BLINK
end

return ability_object
