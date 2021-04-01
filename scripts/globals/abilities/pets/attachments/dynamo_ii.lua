-----------------------------------
-- Attachment: Dynamo II
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    pet:addMod(xi.mod.CRITHITRATE, 5)
end

attachment_object.onUnequip = function(pet)
    pet:delMod(xi.mod.CRITHITRATE, 5)
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(xi.mod.CRITHITRATE, 5)
    elseif maneuvers == 2 then
        pet:addMod(xi.mod.CRITHITRATE, 5)
    elseif maneuvers == 3 then
        pet:addMod(xi.mod.CRITHITRATE, 5)
    end
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(xi.mod.CRITHITRATE, 5)
    elseif maneuvers == 2 then
        pet:delMod(xi.mod.CRITHITRATE, 5)
    elseif maneuvers == 3 then
        pet:delMod(xi.mod.CRITHITRATE, 5)
    end
end

return attachment_object
