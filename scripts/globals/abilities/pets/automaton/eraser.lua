-----------------------------------
-- Eraser
-----------------------------------
require("scripts/globals/automatonweaponskills")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

ability_object.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 30)
    local maneuvers = master:countEffect(xi.effect.LIGHT_MANEUVER)
    skill:setMsg(xi.msg.basic.USES)

    local function removeStatus()
        if target:delStatusEffect(xi.effect.PETRIFICATION) then return true end
        if target:delStatusEffect(xi.effect.SILENCE) then return true end
        if target:delStatusEffect(xi.effect.BANE) then return true end
        if target:delStatusEffect(xi.effect.CURSE_II) then return true end
        if target:delStatusEffect(xi.effect.CURSE_I) then return true end
        if target:delStatusEffect(xi.effect.PARALYSIS) then return true end
        if target:delStatusEffect(xi.effect.PLAGUE) then return true end
        if target:delStatusEffect(xi.effect.POISON) then return true end
        if target:delStatusEffect(xi.effect.DISEASE) then return true end
        if target:delStatusEffect(xi.effect.BLINDNESS) then return true end
        if target:eraseStatusEffect() ~= 255 then return true end
        return false
    end

    local toremove = maneuvers
    local removed = 0

    repeat
        if not removeStatus() then break end
        toremove = toremove - 1
        removed = removed + 1
    until (toremove <= 0)

    for i = 1, maneuvers do
        master:delStatusEffectSilent(xi.effect.LIGHT_MANEUVER)
    end

    return removed
end

return ability_object
