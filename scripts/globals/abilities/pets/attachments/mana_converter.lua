-----------------------------------
-- Attachment: Mana Converter
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_MANA_CONVERTER", function(automaton, target)
        local master = automaton:getMaster()
        local maneuvers = master and master:countEffect(xi.effect.DARK_MANEUVER) or 0
        local mpthreshold = -1
        if maneuvers == 1 then
            mpthreshold = 40
        elseif maneuvers == 2 then
            mpthreshold = 60
        elseif maneuvers == 3 then
            mpthreshold = 65
        end
        local mpp = (automaton:getMaxMP() > 0) and math.ceil(automaton:getMP()/automaton:getMaxMP() * 100) or 100
        if mpp < mpthreshold and automaton:getLocalVar("convert") < VanadielTime() then
            automaton:useMobAbility(1948, automaton)
        end
    end)
end

attachment_object.onUnequip = function(pet)
    pet:removeListener("ATTACHMENT_MANA_CONVERTER")
end

attachment_object.onManeuverGain = function(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
end

return attachment_object
