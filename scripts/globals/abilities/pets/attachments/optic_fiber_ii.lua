-----------------------------------
-- Attachment: Optic Fiber II
-- Increases the performance of other attachments by a percentage
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    pet:addMod(xi.mod.AUTO_PERFORMANCE_BOOST, 15)
end

attachment_object.onUnequip = function(pet)
    pet:delMod(xi.mod.AUTO_PERFORMANCE_BOOST, 15)
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(xi.mod.AUTO_PERFORMANCE_BOOST, 15)
    elseif maneuvers == 2 then
        pet:addMod(xi.mod.AUTO_PERFORMANCE_BOOST, 7)
    elseif maneuvers == 3 then
        pet:addMod(xi.mod.AUTO_PERFORMANCE_BOOST, 8)
    end
    local master = pet:getMaster()
    if master then
        master:updateAttachments()
    end
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(xi.mod.AUTO_PERFORMANCE_BOOST, 15)
    elseif maneuvers == 2 then
        pet:delMod(xi.mod.AUTO_PERFORMANCE_BOOST, 7)
    elseif maneuvers == 3 then
        pet:delMod(xi.mod.AUTO_PERFORMANCE_BOOST, 8)
    end
    local master = pet:getMaster()
    if master then
        master:updateAttachments()
    end
end

return attachment_object
