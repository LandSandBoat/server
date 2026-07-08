-----------------------------------
-- Attachment: Heat Seeker
-- Increases accuracy and ranged accuracy against current target every tick based on the number of Thunder Maneuvers active. Caps at 30 accuracy.
-- Accuracy bonus resets when switching targets.
-- https://wiki.ffo.jp/html/9224.html
-- TODO: Investigate if accuracy bonus decays when maneuvers wear off. Investigate accuracy values, this code is based off very old testing and may not be accurate.
-----------------------------------
---@type TAttachment
local attachmentObject = {}

local accuracyPerTick =
{
    [0] = 0,
    [1] = 1,
    [2] = 2,
    [3] = 3,
}

attachmentObject.onEquip = function(automaton)
    automaton:addListener('AUTOMATON_AI_TICK', 'AUTO_HEAT_SEEKER_TICK', function(pet, target)
        local heatSeekerAccuracyBonus = pet:getLocalVar('heatSeekerAccuracyBonus')
        local currentTarget           = target:getID()
        local heatSeekerTarget        = pet:getLocalVar('heatSeekerTarget')

        -- If the current target is not the same as our stored target, reset accuracy bonus and store the new target.
        if currentTarget ~= heatSeekerTarget then
            if heatSeekerAccuracyBonus > 0 then
                pet:delMod(xi.mod.ACC, heatSeekerAccuracyBonus)
                pet:delMod(xi.mod.RACC, heatSeekerAccuracyBonus)
            end

            pet:setLocalVar('heatSeekerAccuracyBonus', 0)
            pet:setLocalVar('heatSeekerTarget', currentTarget)
            return
        end

        local master = pet:getMaster()

        if not master then
            return
        end

        local thunderManeuvers = xi.automaton.getManeuverCount(master, master:countEffect(xi.effect.THUNDER_MANEUVER))

        if thunderManeuvers == 0 then
            return
        end

        if heatSeekerAccuracyBonus >= 30 then
            return
        end

        -- Calculate the new accuracy bonus based on the number of Thunder Maneuvers and apply it if it's greater than the current bonus. Clamped to a maximum of 30.
        local accuracyBonus = math.min(30, heatSeekerAccuracyBonus + (accuracyPerTick[thunderManeuvers] or 0))
        local accuracyDelta = accuracyBonus - heatSeekerAccuracyBonus

        if accuracyDelta > 0 then
            pet:addMod(xi.mod.ACC, accuracyDelta)
            pet:addMod(xi.mod.RACC, accuracyDelta)
            pet:setLocalVar('heatSeekerAccuracyBonus', accuracyBonus)
        end
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:removeListener('AUTO_HEAT_SEEKER_TICK')

    local heatSeekerAccuracyBonus = pet:getLocalVar('heatSeekerAccuracyBonus')
    if heatSeekerAccuracyBonus > 0 then
        pet:delMod(xi.mod.ACC, heatSeekerAccuracyBonus)
        pet:delMod(xi.mod.RACC, heatSeekerAccuracyBonus)
    end

    pet:setLocalVar('heatSeekerAccuracyBonus', 0)
    pet:setLocalVar('heatSeekerTarget', 0)
end

return attachmentObject
