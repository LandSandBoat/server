-----------------------------------
-- Attachment: Damage Gauge
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    pet:setLocalVar("damagegauge", 1)
    pet:addMod(tpz.mod.AUTO_HEALING_THRESHOLD, 20)
    pet:addMod(tpz.mod.AUTO_HEALING_DELAY, 3)
end

attachment_object.onUnequip = function(pet)
    pet:setLocalVar("damagegauge", 0)
    pet:delMod(tpz.mod.AUTO_HEALING_THRESHOLD, 20)
    pet:delMod(tpz.mod.AUTO_HEALING_DELAY, 3)
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.AUTO_HEALING_THRESHOLD, 20)
        pet:addMod(tpz.mod.AUTO_HEALING_DELAY, 3)
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.AUTO_HEALING_THRESHOLD, 10)
        pet:addMod(tpz.mod.AUTO_HEALING_DELAY, 2)
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.AUTO_HEALING_THRESHOLD, 10)
        pet:addMod(tpz.mod.AUTO_HEALING_DELAY, 2)
    end
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.AUTO_HEALING_THRESHOLD, 20)
        pet:delMod(tpz.mod.AUTO_HEALING_DELAY, 3)
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.AUTO_HEALING_THRESHOLD, 10)
        pet:delMod(tpz.mod.AUTO_HEALING_DELAY, 2)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.AUTO_HEALING_THRESHOLD, 10)
        pet:delMod(tpz.mod.AUTO_HEALING_DELAY, 2)
    end
end

attachment_object.onEquip = function(pet)
    onUpdate(pet, 0)
end

attachment_object.onUnequip = function(pet)
    updateModPerformance(pet, tpz.mod.AUTO_HEALING_THRESHOLD, 'damage_gauge_threshold', 0)
    updateModPerformance(pet, tpz.mod.AUTO_HEALING_DELAY, 'damage_gauge_delay', 0)
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

attachment_object.onUpdate = function(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.AUTO_HEALING_THRESHOLD, 'damage_gauge_threshold', 20, 90)
        updateModPerformance(pet, tpz.mod.AUTO_HEALING_DELAY, 'damage_gauge_delay', 3)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.AUTO_HEALING_THRESHOLD, 'damage_gauge_threshold', 40, 90)
        updateModPerformance(pet, tpz.mod.AUTO_HEALING_DELAY, 'damage_gauge_delay', 6)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.AUTO_HEALING_THRESHOLD, 'damage_gauge_threshold', 50, 90)
        updateModPerformance(pet, tpz.mod.AUTO_HEALING_DELAY, 'damage_gauge_delay', 8)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.AUTO_HEALING_THRESHOLD, 'damage_gauge_threshold', 60, 90)
        updateModPerformance(pet, tpz.mod.AUTO_HEALING_DELAY, 'damage_gauge_delay', 10)
    end
end

return attachment_object
