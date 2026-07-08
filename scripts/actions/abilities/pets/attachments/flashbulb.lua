-----------------------------------
-- Flashbulb
-- Applies "Flash" to the target.
-- https://wiki.ffo.jp/html/6295.html
-----------------------------------
---@type TAttachment
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    pet:addListener('AUTOMATON_ATTACHMENT_CHECK', 'ATTACHMENT_FLASHBULB', function(automaton, target)
        -- If Flashbulb is still on cooldown, do nothing.
        if automaton:hasRecast(xi.recast.ABILITY, xi.mobSkill.FLASHBULB_AUTOMATON) then
            return
        end

        local master = automaton:getMaster()

        if not master then
            return
        end

        local lightManeuvers = master:countEffect(xi.effect.LIGHT_MANEUVER)

        -- If no Light Maneuvers are active, do nothing.
        if lightManeuvers == 0 then
            return
        end

        automaton:useMobAbility(xi.mobSkill.FLASHBULB_AUTOMATON)
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:removeListener('ATTACHMENT_FLASHBULB')
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
