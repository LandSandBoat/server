-----------------------------------
-- Attachment: Damage Gauge
-- Raises the activation threshold of Regulator from 50% to 75%.
-- Raises the threshold at which the automaton will prioritize healing players based off Light Maneuvers.
-- Reduces the cooldown of healing magic by 3 seconds.
-- Does not stack with Damage Gauge II.
-- https://wiki.ffo.jp/html/8624.html
-----------------------------------
---@type TAttachment
local attachmentObject = {}

attachmentObject.onEquip = function(pet, attachment)
    if pet:hasAttachmentSet(xi.item.DAMAGE_GAUGE_II_ATTACHMENT) then
        return
    else
        xi.automaton.onAttachmentEquip(pet, attachment)
    end
end

attachmentObject.onUnequip = function(pet, attachment)
    if pet:hasAttachmentSet(xi.item.DAMAGE_GAUGE_II_ATTACHMENT) then
        return
    else
        xi.automaton.onAttachmentUnequip(pet, attachment)
    end
end

attachmentObject.onManeuverGain = function(pet, attachment, maneuvers)
    if pet:hasAttachmentSet(xi.item.DAMAGE_GAUGE_II_ATTACHMENT) then
        return
    else
        xi.automaton.onManeuverGain(pet, attachment, maneuvers)
    end
end

attachmentObject.onManeuverLose = function(pet, attachment, maneuvers)
    if pet:hasAttachmentSet(xi.item.DAMAGE_GAUGE_II_ATTACHMENT) then
        return
    else
        xi.automaton.onManeuverLose(pet, attachment, maneuvers)
    end
end

attachmentObject.onUpdate = function(pet, attachment, maneuvers)
    if pet:hasAttachmentSet(xi.item.DAMAGE_GAUGE_II_ATTACHMENT) then
        return
    else
        xi.automaton.updateAttachmentModifier(pet, attachment, maneuvers)
    end
end

return attachmentObject
