-----------------------------------
-- Attachment: Inhibitor
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    updateModPerformance(pet, tpz.mod.STORETP, 'inhibitor_mod', 5)
    pet:addMod(tpz.mod.AUTO_TP_EFFICIENCY, 900)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.STORETP, 'inhibitor_mod', 0)
    pet:delMod(tpz.mod.AUTO_TP_EFFICIENCY, 900)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.STORETP, 'inhibitor_mod', 5)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.STORETP, 'inhibitor_mod', 15)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.STORETP, 'inhibitor_mod', 25)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.STORETP, 'inhibitor_mod', 40)
    end
end

return attachment_object
