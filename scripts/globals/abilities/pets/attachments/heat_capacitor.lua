-----------------------------------
-- Attachment: Heat Capacitor
-----------------------------------
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    pet:setLocalVar("heat_capacitor", pet:getLocalVar("heat_capacitor") + 1)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_HEAT_CAPACITOR", function(automaton, target)
        local master = automaton:getMaster()
        if
            master and
            master:countEffect(xi.effect.FIRE_MANEUVER) > 0 and
            automaton:getLocalVar("meditate") < VanadielTime()
        then
            automaton:useMobAbility(2745, automaton)
        end
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:setLocalVar("heat_capacitor", pet:getLocalVar("heat_capacitor") - 1)
    pet:removeListener("ATTACHMENT_HEAT_CAPACITOR")
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
