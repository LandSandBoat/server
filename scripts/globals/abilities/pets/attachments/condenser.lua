-----------------------------------
-- Attachment: Condenser
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    pet:addMod(xi.mod.PREVENT_OVERLOAD, 1)
end

attachment_object.onUnequip = function(pet)
    pet:delMod(xi.mod.PREVENT_OVERLOAD, 1)
end

attachment_object.onManeuverGain = function(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
end

return attachment_object
