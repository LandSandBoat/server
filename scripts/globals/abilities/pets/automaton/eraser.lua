-----------------------------------
-- Eraser
-----------------------------------
require("scripts/globals/automatonweaponskills")
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

local removableStatus =
{
    xi.effect.PETRIFICATION,
    xi.effect.SILENCE,
    xi.effect.BANE,
    xi.effect.CURSE_II,
    xi.effect.CURSE_I,
    xi.effect.PARALYSIS,
    xi.effect.PLAGUE,
    xi.effect.POISON,
    xi.effect.DISEASE,
    xi.effect.BLINDNESS,
}

local function removeStatus(target)
    for _, effectId in ipairs(removableStatus) do
        if target:delStatusEffect(effectId) then
            return true
        end
    end

    if target:eraseStatusEffect() ~= xi.effect.NONE then
        return true
    end

    return false
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 30)
    local maneuvers = master:countEffect(xi.effect.LIGHT_MANEUVER)
    skill:setMsg(xi.msg.basic.USES)

    local toremove = maneuvers
    local removed = 0

    repeat
        if not removeStatus(target) then
            break
        end

        toremove = toremove - 1
        removed = removed + 1
    until toremove <= 0

    for i = 1, maneuvers do
        master:delStatusEffectSilent(xi.effect.LIGHT_MANEUVER)
    end

    return removed
end

return abilityObject
