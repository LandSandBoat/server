-----------------------------------
-- Attachment: Heatsink
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    pet:addMod(tpz.mod.BURDEN_DECAY, 2)
end

attachment_object.onUnequip = function(pet)
    pet:delMod(tpz.mod.BURDEN_DECAY, 2)
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.BURDEN_DECAY, 2)
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.BURDEN_DECAY, 1)
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.BURDEN_DECAY, 1)
    end
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.BURDEN_DECAY, 2)
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.BURDEN_DECAY, 1)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.BURDEN_DECAY, 1)
    end
end

return attachment_object
