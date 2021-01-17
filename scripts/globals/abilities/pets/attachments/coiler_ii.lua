-----------------------------------
-- Attachment: Coiler II
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    pet:addMod(tpz.mod.DOUBLE_ATTACK, 10)
end

function onUnequip(pet)
    pet:delMod(tpz.mod.DOUBLE_ATTACK, 10)
end

function onManeuverGain(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.DOUBLE_ATTACK, 5)
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.DOUBLE_ATTACK, 10)
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.DOUBLE_ATTACK, 10)
    end
end

function onManeuverLose(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.DOUBLE_ATTACK, 5)
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.DOUBLE_ATTACK, 10)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.DOUBLE_ATTACK, 10)
    end
end

return attachment_object
