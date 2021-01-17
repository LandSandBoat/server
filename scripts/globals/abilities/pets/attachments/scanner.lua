-----------------------------------
-- Attachment: Scanner
-- Custom effect since retail's apparently did nothing
-- Causes the Automaton to always use an elemental nuke that the target is weak to, or the strongest, and ignore maneuvers
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    pet:addMod(tpz.mod.AUTO_SCAN_RESISTS, 1)
end

function onUnequip(pet)
    pet:delMod(tpz.mod.AUTO_SCAN_RESISTS, 1)
end

function onManeuverGain(pet, maneuvers)
    --[[if maneuvers == 1 then
        pet:addMod(tpz.mod.AUTO_SCAN_RESISTS, 1)
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.AUTO_SCAN_RESISTS, 1)
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.AUTO_SCAN_RESISTS, 1)
    end]]
end

function onManeuverLose(pet, maneuvers)
    --[[if maneuvers == 1 then
        pet:delMod(tpz.mod.AUTO_SCAN_RESISTS, 1)
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.AUTO_SCAN_RESISTS, 1)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.AUTO_SCAN_RESISTS, 1)
    end]]
end

return attachment_object
