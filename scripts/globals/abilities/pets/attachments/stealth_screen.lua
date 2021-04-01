-----------------------------------
-- Attachment: Stealth Screen
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    attachment_object.onUpdate(pet, 0)
end

attachment_object.onUnequip = function(pet)
    updateModPerformance(pet, xi.mod.ENMITY, 'stealth_screen_mod', 0)
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    attachment_object.onUpdate(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    attachment_object.onUpdate(pet, maneuvers - 1)
end

attachment_object.onUpdate = function(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, xi.mod.ENMITY, 'stealth_screen_mod', -10)
    elseif maneuvers == 1 then
        updateModPerformance(pet, xi.mod.ENMITY, 'stealth_screen_mod', -20)
    elseif maneuvers == 2 then
        updateModPerformance(pet, xi.mod.ENMITY, 'stealth_screen_mod', -30)
    elseif maneuvers == 3 then
        updateModPerformance(pet, xi.mod.ENMITY, 'stealth_screen_mod', -40)
    end
end

return attachment_object
