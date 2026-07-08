-----------------------------------
-- Economizer
-- Recovers a percentage of missing MP based on dark maneuvers.
-- Activation threshold is 30% MP, increasing by 10% per dark maneuver.
-- Applies 7/14/21 Dark Burden per Maneuver active when activated.
-- https://wiki.ffo.jp/html/10435.html
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

local burdenApplied =
{
    [1] = 7,
    [2] = 14,
    [3] = 21,
}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 180)

    local darkManeuvers = master:countEffect(xi.effect.DARK_MANEUVER)
    local mpRecovered   = math.floor(automaton:getMaxMP() * 0.2 * darkManeuvers)
    local burdenAmount  = burdenApplied[darkManeuvers]

    if burdenAmount then
        master:addBurden(xi.element.DARK - 1, burdenAmount)
    end

    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_MP)

    return automaton:addMP(mpRecovered)
end

return abilityObject
