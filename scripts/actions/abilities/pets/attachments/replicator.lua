-----------------------------------
-- Attachment: Replicator
-----------------------------------
---@type TAttachment
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    pet:addListener('AUTOMATON_ATTACHMENT_CHECK', 'ATTACHMENT_REPLICATOR', function(automaton, target)
        local master = automaton:getMaster()

        -- If no master, return.
        if not master then
            return
        end

        -- If blink or copy image is still active, return.
        if
            automaton:hasStatusEffect(xi.effect.BLINK) or
            automaton:hasStatusEffect(xi.effect.COPY_IMAGE)
        then
            return
        end

        local windManeuvers = master:countEffect(xi.effect.WIND_MANEUVER)

        -- If no wind maneuvers, return.
        if windManeuvers == 0 then
            return
        end

        -- If Replicator is on cooldown, return.
        if automaton:hasRecast(xi.recast.ABILITY, xi.mobSkill.REPLICATOR_AUTOMATON) then
            return
        end

        local activationThreshold = 50

        -- If Damage Gauge is equipped, increase activation threshold to 75%.
        if
            automaton:hasAttachmentSet(xi.item.DAMAGE_GAUGE_ATTACHMENT) or
            automaton:hasAttachmentSet(xi.item.DAMAGE_GAUGE_II_ATTACHMENT)
        then
            activationThreshold = 75
        end

        -- If HP is above activation threshold, return.
        if automaton:getHPP() > activationThreshold then
            return
        end

        automaton:useMobAbility(xi.mobSkill.REPLICATOR_AUTOMATON, automaton)
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:removeListener('ATTACHMENT_REPLICATOR')
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
