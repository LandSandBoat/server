-----------------------------------
-- Attachment: Barrage Turbine
-----------------------------------
---@type TAttachment
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    pet:addListener('AUTOMATON_ATTACHMENT_CHECK', 'ATTACHMENT_BARRAGE_TURBINE', function(automaton, target)
        local master = automaton:getMaster()

        if
            not automaton:hasRecast(xi.recast.ABILITY, xi.automaton.abilities.BARRAGE_TURBINE) and
            master and
            master:countEffect(xi.effect.WIND_MANEUVER) > 0
        then
            automaton:useMobAbility(xi.automaton.abilities.BARRAGE_TURBINE, target)
        end
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
