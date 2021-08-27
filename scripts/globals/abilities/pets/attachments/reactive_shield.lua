-----------------------------------
-- Attachment: Reactive Shield
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
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

attachment_object.onUnequip = function(pet)
    pet:removeListener("ATTACHMENT_REACTIVE_SHIELD")
end

attachment_object.onManeuverGain = function(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
end

return attachment_object
