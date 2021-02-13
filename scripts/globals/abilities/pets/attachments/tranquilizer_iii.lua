-----------------------------------
-- Attachment: Tranquilizer III
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    pet:addMod(tpz.mod.MACC, 30) -- Values are best guess
end

attachment_object.onUnequip = function(pet)
    pet:delMod(tpz.mod.MACC, 30) -- Since none of the wikis seem to have data
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.MACC, 20) -- And normally next level attachments
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.MACC, 10) -- Will incrament by +10
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.MACC, 15) -- So leaving values at Tranq II values
    end
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.MACC, 20) -- And incramenting by +10
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.MACC, 10)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.MACC, 15)
    end
end

return attachment_object
