-----------------------------------
-- Attachment: Reactive Shield
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_REACTIVE_SHIELD", function(automaton, target)
        local master = automaton:getMaster()
        if
            not automaton:hasRecast(xi.recast.ABILITY, xi.automaton.abilities.REACTIVE_SHIELD) and
            master and
            master:countEffect(xi.effect.FIRE_MANEUVER) > 0
        then
            automaton:useMobAbility(xi.automaton.abilities.REACTIVE_SHIELD, automaton)
        end
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:removeListener("ATTACHMENT_REACTIVE_SHIELD")
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
