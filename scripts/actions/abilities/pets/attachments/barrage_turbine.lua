-----------------------------------
-- Attachment: Barrage Turbine
-----------------------------------
---@type TAttachment
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    pet:addListener('AUTOMATON_ATTACHMENT_CHECK', 'ATTACHMENT_BARRAGE_TURBINE', function(automaton, target)
        -- If Barrage Turbine is still on cooldown, do nothing.
        if automaton:hasRecast(xi.recast.ABILITY, xi.mobSkill.BARRAGE_TURBINE_AUTOMATON) then
            return
        end

        local master = automaton:getMaster()

        if not master then
            return
        end

        -- If no Wind Maneuvers are active, do nothing.
        if master:countEffect(xi.effect.WIND_MANEUVER) == 0 then
            return
        end

        automaton:useMobAbility(xi.mobSkill.BARRAGE_TURBINE_AUTOMATON, target)
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:removeListener('ATTACHMENT_BARRAGE_TURBINE')
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
