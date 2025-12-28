-----------------------------------
-- Attachment: Disruptor
-----------------------------------
---@type TAttachment
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    pet:addListener('AUTOMATON_ATTACHMENT_CHECK', 'ATTACHMENT_DISRUPTOR', function(automaton, target)
        local master = automaton:getMaster()
        if
            master and
            master:countEffect(xi.effect.DARK_MANEUVER) > 0 and
            automaton:getLocalVar('dispel') < VanadielTime() and
            target:hasStatusEffectByFlag(xi.effectFlag.DISPELABLE) and
            automaton:checkDistance(target) < (7 + target:getHitboxSize() + automaton:getHitboxSize()) -- needs verification
        then
            automaton:useMobAbility(xi.automaton.abilities.DISRUPTOR)
        end
    end)
end

attachmentObject.onUnequip = function(pet)
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
