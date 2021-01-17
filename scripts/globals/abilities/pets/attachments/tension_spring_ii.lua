-----------------------------------
-- Attachment: Tension Spring II
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    onUpdate(pet, 0)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.ATTP, 'tension_ii_attp', 0)
    updateModPerformance(pet, tpz.mod.RATTP, 'tension_ii_rattp', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.ATTP, 'tension_ii_attp', 6)
        updateModPerformance(pet, tpz.mod.RATTP, 'tension_ii_rattp', 6)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.ATTP, 'tension_ii_attp', 9)
        updateModPerformance(pet, tpz.mod.RATTP, 'tension_ii_rattp', 9)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.ATTP, 'tension_ii_attp', 12)
        updateModPerformance(pet, tpz.mod.RATTP, 'tension_ii_rattp', 12)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.ATTP, 'tension_ii_attp', 15)
        updateModPerformance(pet, tpz.mod.RATTP, 'tension_ii_rattp', 15)
    end
end

return attachment_object
