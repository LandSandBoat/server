-----------------------------------
-- Attachment: Economizer
-----------------------------------
require("scripts/globals/automaton")
-----------------------------------
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_ECONOMIZER", function(automaton, target)
        local master = automaton:getMaster()
        local maneuvers = (master and master:countEffect(xi.effect.DARK_MANEUVER) > 0) and master:countEffect(xi.effect.DARK_MANEUVER) or 7
        local mpthreshold = 60 - maneuvers * 10
        local mpp = automaton:getMaxMP() > 0 and math.ceil(automaton:getMP() / automaton:getMaxMP() * 100) or 100
        if
            mpp < mpthreshold and
            not automaton:hasRecast(xi.recast.ABILITY, xi.automaton.abilities.ECONOMIZER)
        then
            automaton:useMobAbility(xi.automaton.abilities.ECONOMIZER, automaton)
        end
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:removeListener("ATTACHMENT_ECONOMIZER")
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
