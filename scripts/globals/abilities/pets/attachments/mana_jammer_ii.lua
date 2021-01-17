-----------------------------------
-- Attachment: Mana Jammer II
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    onUpdate(pet, 0)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.MDEF, 'mana_jammer_ii_mod', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.MDEF, 'mana_jammer_ii_mod', 20)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.MDEF, 'mana_jammer_ii_mod', 30)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.MDEF, 'mana_jammer_ii_mod', 40)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.MDEF, 'mana_jammer_ii_mod', 50)
    end
end

return attachment_object
