-----------------------------------
-- Attachment: Damage Gauge II
-- Raises the activation threshold of Regulator from 50% to 75%.
-- Raises the threshold at which the automaton will prioritize healing players based off Light Maneuvers.
-- Reduces the cooldown of healing magic by 3 seconds.
-- Does not stack with and overrides the effects of Damage Gauge.
-- https://wiki.ffo.jp/html/8624.html
-----------------------------------
---@type TAttachment
local attachmentObject = {}

attachmentObject.onEquip = function(pet, attachment)
    xi.automaton.onAttachmentEquip(pet, attachment)
end

attachmentObject.onUnequip = function(pet, attachment)
    xi.automaton.onAttachmentUnequip(pet, attachment)
end

attachmentObject.onManeuverGain = function(pet, attachment, maneuvers)
    xi.automaton.onManeuverGain(pet, attachment, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, attachment, maneuvers)
    xi.automaton.onManeuverLose(pet, attachment, maneuvers)
end

attachmentObject.onUpdate = function(pet, attachment, maneuvers)
    xi.automaton.updateAttachmentModifier(pet, attachment, maneuvers)
end

return attachmentObject
