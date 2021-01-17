-----------------------------------
-- Attachment: Dynamo
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    pet:addMod(tpz.mod.CRITHITRATE, 3)
end

function onUnequip(pet)
    pet:delMod(tpz.mod.CRITHITRATE, 3)
end

function onManeuverGain(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.CRITHITRATE, 2)
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.CRITHITRATE, 2)
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.CRITHITRATE, 2)
    end
end

function onManeuverLose(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.CRITHITRATE, 2)
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.CRITHITRATE, 2)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.CRITHITRATE, 2)
    end
end

return attachment_object
