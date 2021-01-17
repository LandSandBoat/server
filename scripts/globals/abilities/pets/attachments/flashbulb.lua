-----------------------------------
-- Attachment: Flashbulb
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_FLASHBULB", function(automaton, target)
        local master = automaton:getMaster()
        if not automaton:hasRecast(tpz.recast.ABILITY, 1947) and master and master:countEffect(tpz.effect.LIGHT_MANEUVER) > 0 and (automaton:checkDistance(target) - target:getModelSize()) < 7 then
            automaton:useMobAbility(1947)
        end
    end)
end

function onUnequip(pet)
    pet:removeListener("ATTACHMENT_FLASHBULB")
end

function onManeuverGain(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
end

return attachment_object
