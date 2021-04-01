-----------------------------------
-- Attachment: Hammermill
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    pet:addMod(xi.mod.SHIELD_BASH, 30)
end

attachment_object.onUnequip = function(pet)
    pet:delMod(xi.mod.SHIELD_BASH, 30)
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(xi.mod.SHIELD_BASH, 20)
        pet:addMod(xi.mod.AUTO_SHIELD_BASH_SLOW, 12)
    elseif maneuvers == 2 then
        pet:addMod(xi.mod.SHIELD_BASH, 50)
        pet:addMod(xi.mod.AUTO_SHIELD_BASH_SLOW, 7)
    elseif maneuvers == 3 then
        pet:addMod(xi.mod.SHIELD_BASH, 100)
        pet:addMod(xi.mod.AUTO_SHIELD_BASH_SLOW, 6)
    end
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(xi.mod.SHIELD_BASH, 20)
        pet:delMod(xi.mod.AUTO_SHIELD_BASH_SLOW, 12)
    elseif maneuvers == 2 then
        pet:delMod(xi.mod.SHIELD_BASH, 50)
        pet:delMod(xi.mod.AUTO_SHIELD_BASH_SLOW, 7)
    elseif maneuvers == 3 then
        pet:delMod(xi.mod.SHIELD_BASH, 100)
        pet:delMod(xi.mod.AUTO_SHIELD_BASH_SLOW, 6)
    end
end

return attachment_object
