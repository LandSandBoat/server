-----------------------------------
-- Attachment: Strobe II
-- http://forum.square-enix.com/ffxi/threads/49065?p=565264#post565264
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    xi.automaton.onAttachmentEquip(pet, attachment)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_STROBE_II", function(automaton, target)
        local master = automaton:getMaster()

        if master and master:countEffect(xi.effect.FIRE_MANEUVER) > 0 and (automaton:checkDistance(target) - target:getModelSize()) <= 15 then
            automaton:useMobAbility(1945)
        else
            return 0
        end
    end)
end

attachment_object.onUnequip = function(pet)
    xi.automaton.onAttachmentUnequip(pet, attachment)
    pet:removeListener("ATTACHMENT_STROBE_II")
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    xi.automaton.onManeuverGain(pet, attachment, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    xi.automaton.onManeuverLose(pet, attachment, maneuvers)
end

attachment_object.onUpdate = function(pet, maneuvers)
    xi.automaton.updateAttachmentModifier(pet, attachment, maneuvers)
end

return attachment_object
