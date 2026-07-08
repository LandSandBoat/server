-----------------------------------
-- Attachment: Strobe
-- http://forum.square-enix.com/ffxi/threads/49065?p=565264#post565264
-----------------------------------
---@type TAttachment
local attachmentObject = {}

attachmentObject.onEquip = function(pet, attachment)
    xi.automaton.onAttachmentEquip(pet, attachment)
    pet:addListener('AUTOMATON_ATTACHMENT_CHECK', 'ATTACHMENT_STROBE', function(automaton, target)
        if automaton:hasRecast(xi.recast.ABILITY, xi.mobSkill.PROVOKE_AUTOMATON) then
            return
        end

        local master = automaton:getMaster()

        if not master then
            return
        end

        if master:countEffect(xi.effect.FIRE_MANEUVER) <= 0 then
            return
        end

        if automaton:checkDistance(target) <= (16 + target:getHitboxSize() + automaton:getHitboxSize()) then -- Needs Verification
            automaton:useMobAbility(xi.mobSkill.PROVOKE_AUTOMATON)
        end
    end)
end

attachmentObject.onUnequip = function(pet, attachment)
    xi.automaton.onAttachmentUnequip(pet, attachment)
    pet:removeListener('ATTACHMENT_STROBE')
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
