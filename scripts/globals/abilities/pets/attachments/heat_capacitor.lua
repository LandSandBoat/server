-----------------------------------
-- Attachment: Heat Capacitor
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    pet:setLocalVar("heat_capacitor", pet:getLocalVar("heat_capacitor") + 1)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_HEAT_CAPACITOR", function(automaton, target)
        local master = automaton:getMaster()
        if master and master:countEffect(tpz.effect.FIRE_MANEUVER) > 0 and automaton:getLocalVar("meditate") < VanadielTime() then
            automaton:useMobAbility(2745, automaton)
        end
    end)
end

function onUnequip(pet)
    pet:setLocalVar("heat_capacitor", pet:getLocalVar("heat_capacitor") - 1)
    pet:removeListener("ATTACHMENT_HEAT_CAPACITOR")
end

function onManeuverGain(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
end

return attachment_object
