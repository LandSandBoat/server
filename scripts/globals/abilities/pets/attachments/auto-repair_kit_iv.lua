-----------------------------------
-- Attachment: Auto-repair Kit IV
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet, attachment)
    xi.automaton.onAttachmentEquip(pet, attachment)
end

attachment_object.onUnequip = function(pet, attachment)
    xi.automaton.onAttachmentUnequip(pet, attachment)
end

attachment_object.onManeuverGain = function(pet, attachment, maneuvers)
    attachment_object.onUpdate(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, attachment, maneuvers)
    attachment_object.onUpdate(pet, maneuvers - 1)
end

attachment_object.onUpdate = function(pet, attachment, maneuvers)
    local power = 0
    if maneuvers > 0 then
        power = math.floor(12 + 3 * maneuvers + (pet:getMaxHP() * (2.4 + 0.6 * maneuvers) / 100))
    end
    xi.automaton.updateModPerformance(pet, xi.mod.REGEN, 'autorepair_kit_ii_mod', power)
end

return attachment_object
