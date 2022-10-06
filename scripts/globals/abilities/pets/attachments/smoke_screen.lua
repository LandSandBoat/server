-----------------------------------
-- Attachment: Smoke Screen
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    pet:addMod(xi.mod.EVA, 20)
    pet:addMod(xi.mod.ACC, -20)
end

attachmentObject.onUnequip = function(pet)
    pet:delMod(xi.mod.EVA, 20)
    pet:delMod(xi.mod.ACC, -20)
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(xi.mod.EVA, 20)
        pet:addMod(xi.mod.ACC, -20)
    elseif maneuvers == 2 then
        pet:addMod(xi.mod.EVA, 40)
        pet:addMod(xi.mod.ACC, -40)
    elseif maneuvers == 3 then
        pet:addMod(xi.mod.EVA, 80)
        pet:addMod(xi.mod.ACC, -80)
    end
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(xi.mod.EVA, 20)
        pet:delMod(xi.mod.ACC, -20)
    elseif maneuvers == 2 then
        pet:delMod(xi.mod.EVA, 40)
        pet:delMod(xi.mod.ACC, -40)
    elseif maneuvers == 3 then
        pet:delMod(xi.mod.EVA, 80)
        pet:delMod(xi.mod.ACC, -80)
    end
end

return attachmentObject
