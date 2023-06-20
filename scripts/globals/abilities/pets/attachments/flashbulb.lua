-----------------------------------
-- Attachment: Flashbulb
-----------------------------------
require("scripts/globals/automaton")
-----------------------------------
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_FLASHBULB", function(automaton, target)
        local master = automaton:getMaster()

        if
            not automaton:hasRecast(xi.recast.ABILITY, xi.automaton.abilities.FLASHBULB) and
            master and
            master:countEffect(xi.effect.LIGHT_MANEUVER) > 0 and
            (automaton:checkDistance(target) - target:getModelSize()) < 7
        then
            automaton:useMobAbility(xi.automaton.abilities.FLASHBULB)
        end
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:removeListener("ATTACHMENT_FLASHBULB")
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
