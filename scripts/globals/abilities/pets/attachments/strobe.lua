-----------------------------------
-- Attachment: Strobe
-- http://forum.square-enix.com/ffxi/threads/49065?p=565264#post565264
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet, attachment)
    xi.automaton.onAttachmentEquip(pet, attachment)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_STROBE", function(automaton, target)
        local master = automaton:getMaster()

        if
            master and
            master:countEffect(xi.effect.FIRE_MANEUVER) > 0 and
            (automaton:checkDistance(target) - target:getModelSize()) <= 15
        then
            automaton:useMobAbility(xi.automaton.abilities.PROVOKE)
        end
    end)
end

attachment_object.onUnequip = function(pet, attachment)
    xi.automaton.onAttachmentUnequip(pet, attachment)
    pet:removeListener("ATTACHMENT_STROBE")
end

attachment_object.onManeuverGain = function(pet, attachment, maneuvers)
    xi.automaton.onManeuverGain(pet, attachment, maneuvers)
end

attachment_object.onManeuverLose = function(pet, attachment, maneuvers)
    xi.automaton.onManeuverLose(pet, attachment, maneuvers)
end

attachment_object.onUpdate = function(pet, attachment, maneuvers)
    xi.automaton.updateAttachmentModifier(pet, attachment, maneuvers)
end

return attachment_object
