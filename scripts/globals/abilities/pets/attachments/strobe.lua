-----------------------------------
-- Attachment: Strobe
-- http://forum.square-enix.com/ffxi/threads/49065?p=565264#post565264
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    xi.automaton.updateModPerformance(pet, xi.mod.ENMITY, 'strobe_mod', 10)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_STROBE", function(automaton, target)
        local master = automaton:getMaster()

        if master and master:countEffect(xi.effect.FIRE_MANEUVER) > 0 and (automaton:checkDistance(target) - target:getModelSize()) <= 15 then
            automaton:useMobAbility(1945)
        else
            return 0
        end
    end)
end

attachment_object.onUnequip = function(pet)
    xi.automaton.updateModPerformance(pet, xi.mod.ENMITY, 'strobe_mod', 0)
    pet:removeListener("ATTACHMENT_STROBE")
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    attachment_object.onUpdate(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    attachment_object.onUpdate(pet, maneuvers - 1)
end

attachment_object.onUpdate = function(pet, maneuvers)
    if maneuvers == 0 then
        xi.automaton.updateModPerformance(pet, xi.mod.ENMITY, 'strobe_mod', 10)
    elseif maneuvers == 1 then
        xi.automaton.updateModPerformance(pet, xi.mod.ENMITY, 'strobe_mod', 25)
    elseif maneuvers == 2 then
        xi.automaton.updateModPerformance(pet, xi.mod.ENMITY, 'strobe_mod', 40)
    elseif maneuvers == 3 then
        xi.automaton.updateModPerformance(pet, xi.mod.ENMITY, 'strobe_mod', 60)
    end
end

return attachment_object
