-----------------------------------
-- Attachment: Optic Fiber II
-- Increases the performance of other attachments by a percentage
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    pet:addMod(tpz.mod.AUTO_PERFORMANCE_BOOST, 15)
end

function onUnequip(pet)
    pet:delMod(tpz.mod.AUTO_PERFORMANCE_BOOST, 15)
end

function onManeuverGain(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.AUTO_PERFORMANCE_BOOST, 15)
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.AUTO_PERFORMANCE_BOOST, 7)
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.AUTO_PERFORMANCE_BOOST, 8)
    end
    local master = pet:getMaster()
    if master then
        master:updateAttachments()
    end
end

function onManeuverLose(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.AUTO_PERFORMANCE_BOOST, 15)
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.AUTO_PERFORMANCE_BOOST, 7)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.AUTO_PERFORMANCE_BOOST, 8)
    end
    local master = pet:getMaster()
    if master then
        master:updateAttachments()
    end
end

return attachment_object
