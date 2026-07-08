-----------------------------------
-- Replicator
-- Description : Applies Copy Image based on Wind Maneuvers when HP is below a certain threshold. Cooldown of 1 minute.
-- If Automaton has a Damage Gauge equipped, activation threshold is increased to 75% HP
-- Amount of images increased on December 15th, 2011.
-- Changed from Blink to Copy Image on August 5th, 2015.
-- Changed to not consume Wind Maneuvers on August 6th, 2019.
-- https://wiki.ffo.jp/html/12225.html
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

local shadowTable =
{
    [1] = 3,
    [2] = 7,
    [3] = 10,
}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local windManeuvers = master:countEffect(xi.effect.WIND_MANEUVER)
    local shadows       = shadowTable[windManeuvers]

    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 60)

    if target:addStatusEffect(xi.effect.COPY_IMAGE, { power = shadows, duration = 300, origin = automaton, subPower = shadows }) then
        skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return xi.effect.COPY_IMAGE
end

return abilityObject
