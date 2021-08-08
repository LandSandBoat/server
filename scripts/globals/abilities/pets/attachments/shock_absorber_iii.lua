-----------------------------------
-- Attachment: Shock Absorber III
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    pet:setLocalVar("shockabsorber", pet:getLocalVar("shockabsorber") + 4)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_SHOCK_ABSORBER_III", function(automaton, target)
        local master = automaton:getMaster()

        if
            not automaton:hasRecast(xi.recast.ABILITY, xi.automaton.abilities.SHOCK_ABSORBER) and
            master and
            master:countEffect(xi.effect.EARTH_MANEUVER) > 0 and
        then
            automaton:useMobAbility(xi.automaton.abilities.SHOCK_ABSORBER, automaton)
        end
    end)
end

attachment_object.onUnequip = function(pet)
    pet:setLocalVar("shockabsorber", pet:getLocalVar("shockabsorber") - 4)
    pet:removeListener("ATTACHMENT_SHOCK_ABSORBER_III")
end

attachment_object.onManeuverGain = function(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
end

return attachment_object
