-----------------------------------
-- Attachment: Schurzen
-- Prevents fatal damage and instead leaves the automaton at 1HP and consumes an Earth Manuever
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    pet:addMod(xi.mod.AUTO_SCHURZEN, 1)
end

attachment_object.onUnequip = function(pet)
    pet:delMod(xi.mod.AUTO_SCHURZEN, 1)
end

attachment_object.onManeuverGain = function(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
end

return attachment_object
