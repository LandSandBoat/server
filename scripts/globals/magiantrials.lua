-----------------------------------
-- Magian trials
-----------------------------------
require('scripts/globals/magianobjectives')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.magian = xi.magian or {}

local function hasTrial(player, trialId)
    for i, v in ipairs(getPlayerTrials(player)) do
        if v.trial == trialId then
            return i, v
        end
    end

    return false
end

local function checkAndSetProgression(player, trialId, conditions)
    local trials                   = xi.magian.trials
    local cachePosition, cacheData = hasTrial(player, trialId)

    if trialId and cachePosition then
        local increment = trials[trialId]:check(player, conditions)

        if increment > 0 then
            if cacheData.progress < cacheData.objectiveTotal then
                local newProgress         = math.min(cacheData.progress + increment, cacheData.objectiveTotal)
                local remainingObjectives = cacheData.objectiveTotal - newProgress

                setTrial(player, cachePosition, trialId, newProgress)

                if remainingObjectives == 0 then
                    player:messageBasic(xi.msg.basic.MAGIAN_TRIAL_COMPLETE, trialId) -- trial complete
                else
                    player:messageBasic(xi.msg.basic.MAGIAN_TRIAL_COMPLETE - 1, trialId, remainingObjectives) -- trial <trialid>: x objectives remain
                end

            elseif cacheData.progress > cacheData.objectiveTotal then
                setTrial(player, cachePosition, trialId, cacheData.objectiveTotal)
            end
        end
    end
end

-- increments progress if conditions are met
xi.magian.checkMagianTrial = function(player, conditions)
    for _, slot in pairs({ xi.slot.MAIN, xi.slot.SUB, xi.slot.RANGED }) do
        local trialIdOnItem = player:getEquippedItem(slot) and player:getEquippedItem(slot):getTrialNumber()

        if trialIdOnItem ~= 0 then
            checkAndSetProgression(player, trialIdOnItem, conditions)
        end
    end
end
