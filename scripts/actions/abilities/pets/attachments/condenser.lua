-----------------------------------
-- Attachment: Condenser
-----------------------------------
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    pet:addMod(xi.mod.PREVENT_OVERLOAD, 1)
end

attachmentObject.onUnequip = function(pet)
    pet:delMod(xi.mod.PREVENT_OVERLOAD, 1)
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
