-----------------------------------
-- Attachment: Steam Jacket
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    attachment_object.onUpdate(pet, 0)
end

attachment_object.onUnequip = function(pet)
    xi.automaton.updateModPerformance(pet, xi.mod.AUTO_STEAM_JACKET, 'steam_jacket_mod', 0)
    xi.automaton.updateModPerformance(pet, xi.mod.AUTO_STEAM_JACKED_REDUCTION, 'steam_jacket_reduction', 0)
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    attachment_object.onUpdate(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    attachment_object.onUpdate(pet, maneuvers - 1)
end

attachment_object.onUpdate = function(pet, maneuvers)
    if maneuvers == 0 then
        xi.automaton.updateModPerformance(pet, xi.mod.AUTO_STEAM_JACKET, 'steam_jacket_mod', 2)
        xi.automaton.updateModPerformance(pet, xi.mod.AUTO_STEAM_JACKED_REDUCTION, 'steam_jacket_reduction', 25)
    elseif maneuvers == 1 then
        xi.automaton.updateModPerformance(pet, xi.mod.AUTO_STEAM_JACKET, 'steam_jacket_mod', 3)
        xi.automaton.updateModPerformance(pet, xi.mod.AUTO_STEAM_JACKED_REDUCTION, 'steam_jacket_reduction', 35)
    elseif maneuvers == 2 then
        xi.automaton.updateModPerformance(pet, xi.mod.AUTO_STEAM_JACKET, 'steam_jacket_mod', 4)
        xi.automaton.updateModPerformance(pet, xi.mod.AUTO_STEAM_JACKED_REDUCTION, 'steam_jacket_reduction', 45)
    elseif maneuvers == 3 then
        xi.automaton.updateModPerformance(pet, xi.mod.AUTO_STEAM_JACKET, 'steam_jacket_mod', 5)
        xi.automaton.updateModPerformance(pet, xi.mod.AUTO_STEAM_JACKED_REDUCTION, 'steam_jacket_reduction', 60)
    end
end

return attachment_object
