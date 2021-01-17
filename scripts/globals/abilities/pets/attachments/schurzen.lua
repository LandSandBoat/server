-----------------------------------
-- Attachment: Schurzen
-- Prevents fatal damage and instead leaves the automaton at 1HP and consumes an Earth Manuever
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    pet:addMod(tpz.mod.AUTO_SCHURZEN, 1)
end

function onUnequip(pet)
    pet:delMod(tpz.mod.AUTO_SCHURZEN, 1)
end

function onManeuverGain(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
end

return attachment_object
