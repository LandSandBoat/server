-----------------------------------
-- Replicator
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
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 60)
    local maneuvers = master:countEffect(xi.effect.WIND_MANEUVER)
    local duration = 300
    local shadows = 1 + maneuvers -- math.floor(maneuvers * 3.5) currently on retail

    if target:addStatusEffect(xi.effect.BLINK, shadows, 0, duration) then
        skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
        for i = 1, maneuvers do
            master:delStatusEffectSilent(xi.effect.WIND_MANEUVER)
        end
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return xi.effect.BLINK
end

return abilityObject
