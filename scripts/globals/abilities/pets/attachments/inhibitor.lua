-----------------------------------
-- Attachment: Inhibitor
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    updateModPerformance(pet, xi.mod.STORETP, 'inhibitor_mod', 5)
    pet:addMod(xi.mod.AUTO_TP_EFFICIENCY, 900)
end

attachment_object.onUnequip = function(pet)
    updateModPerformance(pet, xi.mod.STORETP, 'inhibitor_mod', 0)
    pet:delMod(xi.mod.AUTO_TP_EFFICIENCY, 900)
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    attachment_object.onUpdate(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    attachment_object.onUpdate(pet, maneuvers - 1)
end

attachment_object.onUpdate = function(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, xi.mod.STORETP, 'inhibitor_mod', 5)
    elseif maneuvers == 1 then
        updateModPerformance(pet, xi.mod.STORETP, 'inhibitor_mod', 15)
    elseif maneuvers == 2 then
        updateModPerformance(pet, xi.mod.STORETP, 'inhibitor_mod', 25)
    elseif maneuvers == 3 then
        updateModPerformance(pet, xi.mod.STORETP, 'inhibitor_mod', 40)
    end
end

return attachment_object
