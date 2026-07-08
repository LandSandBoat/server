-----------------------------------
-- Disruptor
-- https://wiki.ffo.jp/html/24445.html
-- Removes one beneficial effect from the target.
-----------------------------------
---@type TAttachment
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    pet:addListener('AUTOMATON_ATTACHMENT_CHECK', 'ATTACHMENT_DISRUPTOR', function(automaton, target)
        -- If Disruptor is still on cooldown, do nothing.
        if automaton:hasRecast(xi.recast.ABILITY, xi.mobSkill.DISRUPTOR_AUTOMATON) then
            return
        end

        -- If the target has no dispelable effects, do nothing.
        if not target:hasStatusEffectByFlag(xi.effectFlag.DISPELABLE) then
            return
        end

        local master = automaton:getMaster()

        if not master then
            return
        end

        -- If no Dark Maneuvers are active, do nothing.
        if master:countEffect(xi.effect.DARK_MANEUVER) == 0 then
            return
        end

        automaton:useMobAbility(xi.mobSkill.DISRUPTOR_AUTOMATON, target)
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:removeListener('ATTACHMENT_DISRUPTOR')
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
