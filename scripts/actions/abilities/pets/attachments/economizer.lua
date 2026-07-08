-----------------------------------
-- Economizer
-- Recovers a percentage of missing MP based on dark maneuvers.
-- Activation threshold is 30% MP, increasing by 10% per dark maneuver.
-- https://wiki.ffo.jp/html/10435.html
-----------------------------------
---@type TAttachment
local attachmentObject = {}

local activationThresholds =
{
    [0] = 30,
    [1] = 40,
    [2] = 50,
    [3] = 60,
}

attachmentObject.onEquip = function(pet)
    pet:addListener('AUTOMATON_ATTACHMENT_CHECK', 'ATTACHMENT_ECONOMIZER', function(automaton, target)
        -- If Economizer is still on cooldown, do nothing.
        if automaton:hasRecast(xi.recast.ABILITY, xi.mobSkill.ECONOMIZER_AUTOMATON) then
            return
        end

        local master = automaton:getMaster()

        if not master then
            return
        end

        local darkManeuvers = master:countEffect(xi.effect.DARK_MANEUVER)
        local maxMP = automaton:getMaxMP()

        -- If this automaton has no MP, do nothing.
        if maxMP == 0 then
            return
        end

        local mpPercent = automaton:getMPP()
        local mpThreshold = activationThresholds[darkManeuvers] or 30

        -- If the automaton's MP is above the threshold, do nothing.
        if mpPercent > mpThreshold then
            return
        end

        automaton:useMobAbility(xi.mobSkill.ECONOMIZER_AUTOMATON, automaton)
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:removeListener('ATTACHMENT_ECONOMIZER')
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
