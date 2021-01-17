-----------------------------------
-- Attachment: Smoke Screen
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    pet:addMod(tpz.mod.EVA, 20)
    pet:addMod(tpz.mod.ACC, -20)
end

function onUnequip(pet)
    pet:delMod(tpz.mod.EVA, 20)
    pet:delMod(tpz.mod.ACC, -20)
end

function onManeuverGain(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.EVA, 20)
        pet:addMod(tpz.mod.ACC, -20)
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.EVA, 40)
        pet:addMod(tpz.mod.ACC, -40)
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.EVA, 80)
        pet:addMod(tpz.mod.ACC, -80)
    end
end

function onManeuverLose(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.EVA, 20)
        pet:delMod(tpz.mod.ACC, -20)
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.EVA, 40)
        pet:delMod(tpz.mod.ACC, -40)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.EVA, 80)
        pet:delMod(tpz.mod.ACC, -80)
    end
end

return attachment_object
