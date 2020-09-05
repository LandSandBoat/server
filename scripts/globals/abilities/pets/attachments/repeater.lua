-----------------------------------
-- Attachment: Repeater
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    pet:addMod(tpz.mod.DOUBLE_SHOT_RATE, 10)
end

function onUnequip(pet)
    pet:delMod(tpz.mod.DOUBLE_SHOT_RATE, 10)
end

function onManeuverGain(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.DOUBLE_SHOT_RATE, 5)
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.DOUBLE_SHOT_RATE, 20)
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.DOUBLE_SHOT_RATE, 30)
    end
end

function onManeuverLose(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.DOUBLE_SHOT_RATE, 5)
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.DOUBLE_SHOT_RATE, 20)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.DOUBLE_SHOT_RATE, 30)
    end
end