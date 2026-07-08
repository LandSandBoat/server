-----------------------------------
-- Attachment: Analyzer
-- Description: Reduces damage from subsequently used mob skills. Amount of remembered skills varies with Earth Maneuvers.
-- 1 / 2 / 4 / 6 for 0 / 1 / 2 / 3 maneuvers respectively.
-- https://wiki.ffo.jp/html/10746.html
-----------------------------------
---@type TAttachment
local attachmentObject = {}

attachmentObject.onEquip = function(pet, attachment)
    -- Analyzed skills do not carry over between zones, onEquip is called when rebuilding the automaton after zoning.
    for i = 1, 6 do
        pet:setLocalVar('analyzedSkill' .. i, 0)
    end

    pet:addListener('WEAPONSKILL_TAKE', 'ANALYZER_WEAPONSKILL_TAKE', function(mob, target, skill, tp, action)
        local analyzerModifier = target:getMod(xi.mod.AUTO_ANALYZER)
        local incomingSkill    = skill:getID()

        -- If Analyzer modifier is 0, return. (Should be impossible since the attachment wouldn't be equipped, but just in case.)
        if analyzerModifier <= 0 then
            return
        end

        local analyzedSkillCount = math.min(analyzerModifier, 6)

        -- Check if the amount of remembered skills exceeds the amount allowed by the modifier. If so, any skills past the allowed amount are forgotten.
        for i = analyzedSkillCount + 1, 6 do
            target:setLocalVar('analyzedSkill' .. i, 0)
        end

        -- If the incoming skill is one we have already analyzed, return.
        for i = 1, analyzedSkillCount do
            if incomingSkill == target:getLocalVar('analyzedSkill' .. i) then
                return
            end
        end

        -- If the incoming skill is new, shift all analyzed skills down by one and store the new skill as the most recent analyzed skill.
        for i = analyzedSkillCount, 2, -1 do
            target:setLocalVar('analyzedSkill' .. i, target:getLocalVar('analyzedSkill' .. (i - 1)))
        end

        target:setLocalVar('analyzedSkill1', incomingSkill)
    end)

    xi.automaton.onAttachmentEquip(pet, attachment)
end

attachmentObject.onUnequip = function(pet, attachment)
    for i = 1, 6 do
        pet:setLocalVar('analyzedSkill' .. i, 0)
    end

    pet:removeListener('ANALYZER_WEAPONSKILL_TAKE')

    xi.automaton.onAttachmentUnequip(pet, attachment)
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
