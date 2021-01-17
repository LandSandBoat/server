-----------------------------------
-- Attachment: Tranquilizer II
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    pet:addMod(tpz.mod.MACC, 20)
end

function onUnequip(pet)
    pet:delMod(tpz.mod.MACC, 20)
end

function onManeuverGain(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.MACC, 20)
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.MACC, 10)
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.MACC, 15)
    end
end

function onManeuverLose(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.MACC, 20)
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.MACC, 10)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.MACC, 15)
    end
end

return attachment_object
