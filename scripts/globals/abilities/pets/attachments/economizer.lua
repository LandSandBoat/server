-----------------------------------
-- Attachment: Economizer
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_ECONOMIZER", function(automaton, target)
        local master = automaton:getMaster()
        local maneuvers = (master and master:countEffect(tpz.effect.DARK_MANEUVER) > 0) and master:countEffect(tpz.effect.DARK_MANEUVER) or 7
        local mpthreshold = 60 - maneuvers * 10
        local mpp = automaton:getMaxMP() > 0 and math.ceil(automaton:getMP() / automaton:getMaxMP() * 100) or 100
        if mpp < mpthreshold and not automaton:hasRecast(tpz.recast.ABILITY, 2068) then
            automaton:useMobAbility(2068, automaton)
        else
            return 0
        end
    end)
end

attachment_object.onUnequip = function(pet)
    pet:removeListener("ATTACHMENT_ECONOMIZER")
end

attachment_object.onManeuverGain = function(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
end

return attachment_object
