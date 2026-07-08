-----------------------------------
-- Attachment: Shock Absorber II
-----------------------------------
---@type TAttachment
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    pet:addListener('AUTOMATON_ATTACHMENT_CHECK', 'ATTACHMENT_SHOCK_ABSORBER', function(automaton, target)
        if automaton:hasRecast(xi.recast.ABILITY, xi.mobSkill.SHOCK_ABSORBER_AUTOMATON) then
            return
        end

        local master = automaton:getMaster()

        if not master then
            return
        end

        if master:countEffect(xi.effect.EARTH_MANEUVER) == 0 then
            return
        end

        automaton:useMobAbility(xi.mobSkill.SHOCK_ABSORBER_AUTOMATON, automaton)
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:removeListener('ATTACHMENT_SHOCK_ABSORBER')
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
