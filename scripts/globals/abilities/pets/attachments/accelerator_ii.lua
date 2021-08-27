-----------------------------------
-- Attachment: Accelerator II
-----------------------------------
require("scripts/globals/automaton")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet, attachment)
    xi.automaton.onAttachmentEquip(pet, attachment)
end

attachment_object.onUnequip = function(pet, attachment)
    xi.automaton.onAttachmentUnequip(pet, attachment)
end

attachment_object.onManeuverGain = function(pet, attachment, maneuvers)
    xi.automaton.onManeuverGain(pet, attachment, maneuvers)
end

attachment_object.onManeuverLose = function(pet, attachment, maneuvers)
    xi.automaton.onManeuverLose(pet, attachment, maneuvers)
end

attachment_object.onUpdate = function(pet, attachment, maneuvers)
    xi.automaton.updateAttachmentModifier(pet, attachment, maneuvers)
end

return attachment_object
