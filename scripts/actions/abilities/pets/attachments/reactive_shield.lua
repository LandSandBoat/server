-----------------------------------
-- Reactive Shield
-- Grants Blaze Spikes to the automaton for 60 seconds.
-- https://wiki.ffo.jp/html/10431.html
-----------------------------------
---@type TAttachment
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    pet:addListener('AUTOMATON_ATTACHMENT_CHECK', 'ATTACHMENT_REACTIVE_SHIELD', function(automaton, target)
        if automaton:hasRecast(xi.recast.ABILITY, xi.mobSkill.REACTIVE_SHIELD_AUTOMATON) then
            return
        end

        local master = automaton:getMaster()

        if not master then
            return
        end

        local fireManeuvers = master:countEffect(xi.effect.FIRE_MANEUVER)

        if fireManeuvers == 0 then
            return
        end

        automaton:useMobAbility(xi.mobSkill.REACTIVE_SHIELD_AUTOMATON, automaton)
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:removeListener('ATTACHMENT_REACTIVE_SHIELD')
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
