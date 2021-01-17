-----------------------------------
-- Attachment: Shock Absorber
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    pet:setLocalVar("stoneskin", VanadielTime() + 180)
    pet:setLocalVar("shockabsorber", pet:getLocalVar("shockabsorber") + 1)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_SHOCK_ABSORBER", function(automaton, target)
        local master = automaton:getMaster()
        if not automaton:hasRecast(tpz.recast.ABILITY, 1946) and master and master:countEffect(tpz.effect.EARTH_MANEUVER) > 0 and automaton:getLocalVar("stoneskin") < VanadielTime() then
            automaton:useMobAbility(1946, automaton)
        end
    end)
end

function onUnequip(pet)
    pet:setLocalVar("shockabsorber", pet:getLocalVar("shockabsorber") - 1)
    pet:removeListener("ATTACHMENT_SHOCK_ABSORBER")
end

function onManeuverGain(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
end

return attachment_object
