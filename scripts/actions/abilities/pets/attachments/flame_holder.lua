-----------------------------------
-- Attachment: Flame Holder
-- Description : Adds fire maneuver burden to increase weapon skill damage.
-- 25% at 0, 100% at 1, 175% at 2, and 250% at 3. Ex. at 3 fire maneuvers, 10 fTP will be 25 fTP.
-- Applies 7/14/21 Fire Burden per Maneuver active when a weaponskill is executed.
-- https://wiki.ffo.jp/html/11183.html
-----------------------------------
---@type TAttachment
local attachmentObject = {}

local validFlameHolderSkills = set
{
    xi.mobSkill.ARCUBALLISTA_AUTOMATON,
    xi.mobSkill.ARMOR_PIERCER_AUTOMATON,
    xi.mobSkill.ARMOR_SHATTERER_AUTOMATON,
    xi.mobSkill.BONE_CRUSHER_AUTOMATON,
    xi.mobSkill.CANNIBAL_BLADE_AUTOMATON,
    xi.mobSkill.CHIMERA_RIPPER_AUTOMATON,
    xi.mobSkill.DAZE_AUTOMATON,
    xi.mobSkill.KNOCKOUT_AUTOMATON,
    xi.mobSkill.MAGIC_MORTAR_AUTOMATON,
    xi.mobSkill.SLAPSTICK_AUTOMATON,
    xi.mobSkill.STRING_CLIPPER_AUTOMATON,
    xi.mobSkill.STRING_SHREDDER_AUTOMATON,
}

local burdenApplied =
{
    [1] = 7,
    [2] = 14,
    [3] = 21,
}

attachmentObject.onEquip = function(pet, attachment)
    pet:addListener('WEAPONSKILL_STATE_EXIT', 'AUTO_FLAME_HOLDER_END', function(automaton, skillId, wasExecuted)
        if
            not validFlameHolderSkills[skillId] or
            not wasExecuted
        then
            return
        end

        local master = automaton:getMaster()

        if not master then
            return
        end

        local fireManeuvers = master:countEffect(xi.effect.FIRE_MANEUVER)
        local burdenAmount  = burdenApplied[fireManeuvers]

        if burdenAmount then
            master:addBurden(xi.element.FIRE - 1, burdenAmount)
        end
    end)

    xi.automaton.onAttachmentEquip(pet, attachment)
end

attachmentObject.onUnequip = function(pet, attachment)
    xi.automaton.onAttachmentUnequip(pet, attachment)
    pet:removeListener('AUTO_FLAME_HOLDER_END')
end

attachmentObject.onManeuverGain = function(pet, attachment, maneuvers)
    xi.automaton.onManeuverGain(pet, attachment, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, attachment, maneuvers)
    xi.automaton.onManeuverLose(pet, attachment, maneuvers)
end

attachmentObject.onUpdate = function(pet, attachment, maneuvers)
    xi.automaton.updateAttachmentModifier(pet, attachment, maneuvers)
end

return attachmentObject
