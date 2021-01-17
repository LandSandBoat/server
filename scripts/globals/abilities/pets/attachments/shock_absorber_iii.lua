-----------------------------------
-- Attachment: Shock Absorber III
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    pet:setLocalVar("stoneskin", VanadielTime() + 180)
    pet:setLocalVar("shockabsorber", pet:getLocalVar("shockabsorber") + 4)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_SHOCK_ABSORBER_III", function(automaton, target)
        local master = automaton:getMaster()
        if not automaton:hasRecast(tpz.recast.ABILITY, 1946) and master and master:countEffect(tpz.effect.EARTH_MANEUVER) > 0 and automaton:getLocalVar("stoneskin") < VanadielTime() then
            automaton:useMobAbility(1946, automaton)
        end
    end)
end

function onUnequip(pet)
    pet:setLocalVar("shockabsorber", pet:getLocalVar("shockabsorber") - 4)
    pet:removeListener("ATTACHMENT_SHOCK_ABSORBER_III")
end

function onManeuverGain(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
end

return attachment_object
