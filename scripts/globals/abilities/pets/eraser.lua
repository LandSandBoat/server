-----------------------------------
-- Eraser
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
    automaton:addRecast(tpz.recast.ABILITY, skill:getID(), 30)
    local maneuvers = master:countEffect(tpz.effect.LIGHT_MANEUVER)
    skill:setMsg(tpz.msg.basic.USES)

    local function removeStatus()
        if target:delStatusEffect(tpz.effect.PETRIFICATION) then return true end
        if target:delStatusEffect(tpz.effect.SILENCE) then return true end
        if target:delStatusEffect(tpz.effect.BANE) then return true end
        if target:delStatusEffect(tpz.effect.CURSE_II) then return true end
        if target:delStatusEffect(tpz.effect.CURSE_I) then return true end
        if target:delStatusEffect(tpz.effect.PARALYSIS) then return true end
        if target:delStatusEffect(tpz.effect.PLAGUE) then return true end
        if target:delStatusEffect(tpz.effect.POISON) then return true end
        if target:delStatusEffect(tpz.effect.DISEASE) then return true end
        if target:delStatusEffect(tpz.effect.BLINDNESS) then return true end
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
        master:delStatusEffectSilent(tpz.effect.LIGHT_MANEUVER)
    end

    return removed
end

return ability_object
