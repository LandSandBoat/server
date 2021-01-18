-----------------------------------
-- Attachment: Heat Capacitor II
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    pet:setLocalVar("heat_capacitor", pet:getLocalVar("heat_capacitor") + 2)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_HEAT_CAPACITOR_II", function(automaton, target)
        local master = automaton:getMaster()
        if master and master:countEffect(tpz.effect.FIRE_MANEUVER) > 0 and automaton:getLocalVar("meditate") < VanadielTime() then
            automaton:useMobAbility(2745, automaton)
        end
    end)
end

attachment_object.onUnequip = function(pet)
    pet:setLocalVar("heat_capacitor", pet:getLocalVar("heat_capacitor") - 2)
    pet:removeListener("ATTACHMENT_HEAT_CAPACITOR_II")
end

attachment_object.onManeuverGain = function(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
end

return attachment_object
