-----------------------------------
-- Attachment: Barrier Module II
-- Grants Shield Mastery TP bonus based on the number of maneuvers active. This effect is handled here because it does not stack.
-- TODO: Audit Shield Bash Cooldown reduction and block chance.
-- https://wiki.ffo.jp/html/24442.html
-----------------------------------
---@type TAttachment
local attachmentObject = {}

local shieldMasteryTable =
{
    [0] =  0,
    [1] = 10,
    [2] = 20,
    [3] = 30,
}

attachmentObject.onEquip = function(pet, attachment)
    xi.automaton.onAttachmentEquip(pet, attachment)
end

attachmentObject.onUnequip = function(pet, attachment)
    xi.automaton.onAttachmentUnequip(pet, attachment)
    pet:setMod(xi.mod.SHIELD_MASTERY_TP, shieldMasteryTable[0])
end

attachmentObject.onManeuverGain = function(pet, attachment, maneuvers)
    xi.automaton.onManeuverGain(pet, attachment, maneuvers)
    pet:setMod(xi.mod.SHIELD_MASTERY_TP, shieldMasteryTable[maneuvers])
end

attachmentObject.onManeuverLose = function(pet, attachment, maneuvers)
    xi.automaton.onManeuverLose(pet, attachment, maneuvers)
    pet:setMod(xi.mod.SHIELD_MASTERY_TP, shieldMasteryTable[maneuvers])
end

attachmentObject.onUpdate = function(pet, attachment, maneuvers)
    xi.automaton.updateAttachmentModifier(pet, attachment, maneuvers)
    pet:setMod(xi.mod.SHIELD_MASTERY_TP, shieldMasteryTable[maneuvers])
end

return attachmentObject
