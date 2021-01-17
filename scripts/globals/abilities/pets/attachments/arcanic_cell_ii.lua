-----------------------------------
-- Attachment: Arcanic Cell II
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    pet:addMod(tpz.mod.OCCULT_ACUMEN, 20)
end

attachment_object.onUnequip = function(pet)
    pet:delMod(tpz.mod.OCCULT_ACUMEN, 20)
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.OCCULT_ACUMEN, 20)
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.OCCULT_ACUMEN, 30)
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.OCCULT_ACUMEN, 30)
    end
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.OCCULT_ACUMEN, 20)
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.OCCULT_ACUMEN, 30)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.OCCULT_ACUMEN, 30)
    end
end

return attachment_object
