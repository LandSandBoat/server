-----------------------------------
-- Attachment: Replicator
-----------------------------------
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    pet:addListener('AUTOMATON_ATTACHMENT_CHECK', 'ATTACHMENT_REPLICATOR', function(automaton, target)
        local master = automaton:getMaster()
        local hpthreshold = (automaton:getLocalVar('damagegauge') > 0) and 75 or 50

        if
            master and
            master:countEffect(xi.effect.WIND_MANEUVER) > 0 and
            automaton:getHPP() <= hpthreshold and
            not automaton:hasStatusEffect(xi.effect.BLINK)
        then
            automaton:useMobAbility(xi.automaton.abilities.REPLICATOR, automaton)
        end
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
