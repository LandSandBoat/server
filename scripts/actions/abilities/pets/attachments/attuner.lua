-----------------------------------
-- Attachment: Attuner
-----------------------------------
---@type TAttachment
local attachmentObject = {}

-- This is handled in xi.combat.physical.calculateMeleePDIF
attachmentObject.onEquip = function(automaton)
end

attachmentObject.onUnequip = function(pet)
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
