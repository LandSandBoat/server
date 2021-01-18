-----------------------------------
-- Attachment: Auto-repair Kit III
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    -- We do not have support to do a fraction of a percent so we rounded
    local frame = pet:getAutomatonFrame()
    if frame == tpz.frames.HARLEQUIN then
        pet:addMod(tpz.mod.HPP, 15)
    elseif frame == tpz.frames.VALOREDGE then
        pet:addMod(tpz.mod.HPP, 13)
    elseif frame == tpz.frames.SHARPSHOT then
        pet:addMod(tpz.mod.HPP, 17)
    elseif frame == tpz.frames.STORMWAKER then
        pet:addMod(tpz.mod.HPP, 19)
    end
end

attachment_object.onUnequip = function(pet)
    local frame = pet:getAutomatonFrame()
    if frame == tpz.frames.HARLEQUIN then
        pet:delMod(tpz.mod.HPP, 15)
    elseif frame == tpz.frames.VALOREDGE then
        pet:delMod(tpz.mod.HPP, 13)
    elseif frame == tpz.frames.SHARPSHOT then
        pet:delMod(tpz.mod.HPP, 17)
    elseif frame == tpz.frames.STORMWAKER then
        pet:delMod(tpz.mod.HPP, 19)
    end
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

attachment_object.onUpdate = function(pet, maneuvers)
    local power = 0
    if maneuvers > 0 then
        power = math.floor(6 + 3 * maneuvers + (pet:getMaxHP() * (1.2 + 0.6 * maneuvers) / 100))
    end
    updateModPerformance(pet, tpz.mod.REGEN, 'autorepair_kit_ii_mod', power)
end

return attachment_object
