-----------------------------------
-- Heat Capacitor
-- Increases TP based on the number of Fire Maneuvers and the attachments equipped.
-- https://wiki.ffo.jp/html/23696.html
-----------------------------------
---@type TAttachment
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    pet:addListener('AUTOMATON_ATTACHMENT_CHECK', 'ATTACHMENT_HEAT_CAPACITOR', function(automaton, target)
        -- If Heat Capacitor is still on cooldown, do nothing.
        if automaton:hasRecast(xi.recast.ABILITY, xi.mobSkill.HEAT_CAPACITOR_AUTOMATON) then
            return
        end

        local master = automaton:getMaster()

        if not master then
            return
        end

        -- If no Fire Maneuvers are active, do nothing.
        if master:countEffect(xi.effect.FIRE_MANEUVER) == 0 then
            return
        end

        automaton:useMobAbility(xi.mobSkill.HEAT_CAPACITOR_AUTOMATON, automaton)
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:removeListener('ATTACHMENT_HEAT_CAPACITOR')
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
