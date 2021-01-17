-----------------------------------
-- Attachment: Reactive Shield
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_REACTIVE_SHIELD", function(automaton, target)
        local master = automaton:getMaster()
        if not automaton:hasRecast(tpz.recast.ABILITY, 2031) and master and master:countEffect(tpz.effect.FIRE_MANEUVER) > 0 then
            automaton:useMobAbility(2031, automaton)
        end
    end)
end

function onUnequip(pet)
    pet:removeListener("ATTACHMENT_REACTIVE_SHIELD")
end

function onManeuverGain(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
end

return attachment_object
