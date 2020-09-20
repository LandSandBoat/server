-----------------------------------
-- Attachment: Arcanic Cell II
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    pet:addMod(tpz.mod.OCCULT_ACUMEN, 20)
end

function onUnequip(pet)
    pet:delMod(tpz.mod.OCCULT_ACUMEN, 20)
end

function onManeuverGain(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.OCCULT_ACUMEN, 20)
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.OCCULT_ACUMEN, 30)
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.OCCULT_ACUMEN, 30)
    end
end

function onManeuverLose(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.OCCULT_ACUMEN, 20)
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.OCCULT_ACUMEN, 30)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.OCCULT_ACUMEN, 30)
    end
end
