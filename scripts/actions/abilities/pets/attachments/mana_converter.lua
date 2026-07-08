-----------------------------------
-- Mana Converter
-- Converts HP to MP. The amount of MP restored is based on the amount of HP lost.
-- MP is restored over 30 seconds in the form of a Refresh effect.
-- https://wiki.ffo.jp/html/5329.html
-----------------------------------
local activationThresholds =
{
    [1] = 40,
    [2] = 60,
    [3] = 70,
}

---@type TAttachment
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    pet:addListener('AUTOMATON_ATTACHMENT_CHECK', 'ATTACHMENT_MANA_CONVERTER', function(automaton, target)
        -- If Mana Converter is on cooldown, do nothing.
        if automaton:hasRecast(xi.recast.ABILITY, xi.mobSkill.MANA_CONVERTER_AUTOMATON) then
            return
        end

        local master = automaton:getMaster()

        if not master then
            return
        end

        local darkManeuvers = master:countEffect(xi.effect.DARK_MANEUVER)

        -- If no dark maneuvers are active, do nothing.
        if darkManeuvers == 0 then
            return
        end

        local mpThreshold = activationThresholds[darkManeuvers]

        if not mpThreshold then
            return
        end

        local mpPercent = automaton:getMPP()

        -- If MP is above the threshold, do nothing.
        if mpPercent > mpThreshold then
            return
        end

        automaton:useMobAbility(xi.mobSkill.MANA_CONVERTER_AUTOMATON, automaton)
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:removeListener('ATTACHMENT_MANA_CONVERTER')
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
