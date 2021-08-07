-----------------------------------
-- Attachment: Mana Tank II
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    -- We do not have support to do a fraction of a percent so we rounded
    local frame = pet:getAutomatonFrame()
    if frame == xi.frames.HARLEQUIN then
        pet:addMod(xi.mod.MPP, 10)
    elseif frame == xi.frames.STORMWAKER then
        pet:addMod(xi.mod.MPP, 8)
    end
end

attachment_object.onUnequip = function(pet)
    local frame = pet:getAutomatonFrame()
    if frame == xi.frames.HARLEQUIN then
        pet:delMod(xi.mod.MPP, 10)
    elseif frame == xi.frames.STORMWAKER then
        pet:delMod(xi.mod.MPP, 8)
    end
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    attachment_object.onUpdate(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    attachment_object.onUpdate(pet, maneuvers - 1)
end

attachment_object.onUpdate = function(pet, maneuvers)
    local power = 0
    if maneuvers > 0 then
        power = math.floor(1 + maneuvers + (pet:getMaxMP() * (0.2 + 0.2 * maneuvers) / 100))
    end
    xi.automaton.updateModPerformance(pet, xi.mod.REFRESH, 'mana_tank_ii_mod', power)
end

return attachment_object
