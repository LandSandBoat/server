-----------------------------------
-- Attachment: Damage Gauge
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    attachment_object.onUpdate(pet, 0)
end

attachment_object.onUnequip = function(pet)
    xi.automaton.updateModPerformance(pet, xi.mod.AUTO_HEALING_THRESHOLD, 'damage_gauge_threshold', 0)
    xi.automaton.updateModPerformance(pet, xi.mod.AUTO_HEALING_DELAY, 'damage_gauge_delay', 0)
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    attachment_object.onUpdate(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    attachment_object.onUpdate(pet, maneuvers - 1)
end

attachment_object.onUpdate = function(pet, maneuvers)
    if maneuvers == 0 then
        xi.automaton.updateModPerformance(pet, xi.mod.AUTO_HEALING_THRESHOLD, 'damage_gauge_threshold', 20, 90)
        xi.automaton.updateModPerformance(pet, xi.mod.AUTO_HEALING_DELAY, 'damage_gauge_delay', 3)
    elseif maneuvers == 1 then
        xi.automaton.updateModPerformance(pet, xi.mod.AUTO_HEALING_THRESHOLD, 'damage_gauge_threshold', 40, 90)
        xi.automaton.updateModPerformance(pet, xi.mod.AUTO_HEALING_DELAY, 'damage_gauge_delay', 6)
    elseif maneuvers == 2 then
        xi.automaton.updateModPerformance(pet, xi.mod.AUTO_HEALING_THRESHOLD, 'damage_gauge_threshold', 50, 90)
        xi.automaton.updateModPerformance(pet, xi.mod.AUTO_HEALING_DELAY, 'damage_gauge_delay', 8)
    elseif maneuvers == 3 then
        xi.automaton.updateModPerformance(pet, xi.mod.AUTO_HEALING_THRESHOLD, 'damage_gauge_threshold', 60, 90)
        xi.automaton.updateModPerformance(pet, xi.mod.AUTO_HEALING_DELAY, 'damage_gauge_delay', 10)
    end
end

return attachment_object
