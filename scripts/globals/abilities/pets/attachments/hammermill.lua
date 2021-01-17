-----------------------------------
-- Attachment: Hammermill
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    pet:addMod(tpz.mod.SHIELD_BASH, 30)
end

function onUnequip(pet)
    pet:delMod(tpz.mod.SHIELD_BASH, 30)
end

function onManeuverGain(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.SHIELD_BASH, 20)
        pet:addMod(tpz.mod.AUTO_SHIELD_BASH_SLOW, 12)
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.SHIELD_BASH, 50)
        pet:addMod(tpz.mod.AUTO_SHIELD_BASH_SLOW, 7)
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.SHIELD_BASH, 100)
        pet:addMod(tpz.mod.AUTO_SHIELD_BASH_SLOW, 6)
    end
end

function onManeuverLose(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.SHIELD_BASH, 20)
        pet:delMod(tpz.mod.AUTO_SHIELD_BASH_SLOW, 12)
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.SHIELD_BASH, 50)
        pet:delMod(tpz.mod.AUTO_SHIELD_BASH_SLOW, 7)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.SHIELD_BASH, 100)
        pet:delMod(tpz.mod.AUTO_SHIELD_BASH_SLOW, 6)
    end
end

return attachment_object
