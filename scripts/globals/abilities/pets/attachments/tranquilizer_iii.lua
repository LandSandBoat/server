-----------------------------------
-- Attachment: Tranquilizer III
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    pet:addMod(tpz.mod.MACC, 30) -- Values are best guess
end

function onUnequip(pet)
    pet:delMod(tpz.mod.MACC, 30) -- Since none of the wikis seem to have data
end

function onManeuverGain(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.MACC, 20) -- And normally next level attachments
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.MACC, 10) -- Will incrament by +10
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.MACC, 15) -- So leaving values at Tranq II values
    end
end

function onManeuverLose(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.MACC, 20) -- And incramenting by +10
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.MACC, 10)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.MACC, 15)
    end
end

return attachment_object
