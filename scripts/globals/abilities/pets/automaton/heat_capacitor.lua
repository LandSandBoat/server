-----------------------------------
-- Heat Capacitor
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
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 90)
    local maneuvers = master:countEffect(xi.effect.FIRE_MANEUVER)
    skill:setMsg(xi.msg.basic.TP_INCREASE)

    for i = 1, maneuvers do
        master:delStatusEffectSilent(xi.effect.FIRE_MANEUVER)
    end

    if automaton:getLocalVar("heat_capacitor") >= 3 then -- Heat Capacitor & Heat Capacitor II
        target:addTP(1000 * maneuvers)
    elseif automaton:getLocalVar("heat_capacitor") >= 2 then -- Heat Capacitor II
        target:addTP(600 * maneuvers)
    else -- Heat Capacitor
        target:addTP(400 * maneuvers)
    end

    return target:getTP()
end

return abilityObject
