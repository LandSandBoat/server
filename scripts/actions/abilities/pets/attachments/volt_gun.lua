-----------------------------------
-- Attachment: Volt Gun
-----------------------------------
---@type TAttachment
local attachmentObject = {}

local function calcEnspellDmg(pet, maneuvers)
    local skill = math.max(pet:getSkillLevel(xi.skill.AUTOMATON_MELEE), pet:getSkillLevel(xi.skill.AUTOMATON_RANGED), pet:getSkillLevel(xi.skill.AUTOMATON_MAGIC))
    return math.floor(skill / 10 + skill * maneuvers / 20)
end

attachmentObject.onEquip = function(pet, attachment)
    pet:setMod(xi.mod.ENSPELL_DMG, calcEnspellDmg(pet, 0))
    xi.automaton.onAttachmentEquip(pet, attachment)
end

attachmentObject.onUnequip = function(pet, attachment)
    pet:delMod(xi.mod.ENSPELL_DMG, pet:getMod(xi.mod.ENSPELL_DMG))
    xi.automaton.onAttachmentUnequip(pet, attachment)
end

attachmentObject.onManeuverGain = function(pet, attachment, maneuvers)
    pet:setMod(xi.mod.ENSPELL_DMG, calcEnspellDmg(pet, maneuvers))
    xi.automaton.onManeuverGain(pet, attachment, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, attachment, maneuvers)
    pet:setMod(xi.mod.ENSPELL_DMG, calcEnspellDmg(pet, maneuvers))
    xi.automaton.onManeuverLose(pet, attachment, maneuvers)
end

attachmentObject.onUpdate = function(pet, attachment, maneuvers)
    attachmentObject.onManeuverGain(pet, attachment, maneuvers)
    xi.automaton.updateAttachmentModifier(pet, attachment, maneuvers)
end

return attachmentObject
