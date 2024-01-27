-----------------------------------
-- xi.effect.VISITANT
-----------------------------------
local effectObject = {}

local remainingTimeLimits = { 300, 240, 180, 120, 60, 30, 10, 5, 4, 3, 2, 1 }

-- NOTE: Update the last
local reportTimeRemaining
reportTimeRemaining = function(player, effect)
    local ID = zones[player:getZoneID()]
    local lastTimeUpdate = player:getLocalVar('lastTimeUpdate')
    local currentTime = effect:getTimeRemaining() / 1000 - 4
    local messageParam = 0
    local nextTimeReport = 0

    -- All possible forms of TE will reset out of the final two minute warning,
    -- reset this here.
    if currentTime > lastTimeUpdate then
        lastTimeUpdate = currentTime
        player:setLocalVar('finalCountdown', 0)
        return
    end

    for i = 1, #remainingTimeLimits do
        if
            lastTimeUpdate > remainingTimeLimits[i] and
            currentTime <= remainingTimeLimits[i]
        then
            messageParam = remainingTimeLimits[i]
            nextTimeReport = remainingTimeLimits[i] ~= 1 and remainingTimeLimits[i + 1] or 0
            player:setLocalVar('lastTimeUpdate', messageParam)

            if messageParam <= 30 then
                player:setLocalVar('finalCountdown', 1)
            end

            break
        end
    end

    if messageParam > 0 then
        if messageParam >= 60 then
            player:messageSpecial(ID.text.ABYSSEA_TIME_OFFSET + 4, messageParam / 60)
        elseif messageParam > 1 then
            player:messageSpecial(ID.text.ABYSSEA_TIME_OFFSET + 7, messageParam)
        else
            player:messageSpecial(ID.text.ABYSSEA_TIME_OFFSET + 6, messageParam)
        end
    end

    -- Handle the more granular countdown, as effect ticks are only every
    -- three seconds.
    if player:getLocalVar('finalCountdown') == 1 then
        if messageParam > 0 then
            local timerVal = (messageParam - nextTimeReport) * 1000

            player:timer(timerVal, function()
                reportTimeRemaining(player, effect)
            end)
        else
            -- There's 4s of buffer time built in, so that the full countdown is displayed.
            -- If we reached the end, delete the status effect so that the player is ejected.
            player:delStatusEffectSilent(xi.effect.VISITANT)
        end
    end
end

effectObject.onEffectGain = function(target, effect)
    local visEffect = target:getStatusEffect(xi.effect.VISITANT)

    visEffect:addEffectFlag(xi.effectFlag.OFFLINE_TICK)
    visEffect:addEffectFlag(xi.effectFlag.NO_CANCEL)
    visEffect:addEffectFlag(xi.effectFlag.ON_ZONE)
    visEffect:addEffectFlag(xi.effectFlag.HIDE_TIMER)

    target:setLocalVar('lastTimeUpdate', effect:getTimeRemaining() / 1000 + 1)
end

effectObject.onEffectTick = function(target, effect)
    if not xi.abyssea.isInAbysseaZone(target) then
        target:delStatusEffect(effect)
    end

    -- Searing Ward Tether is set and reset in zone onTriggerAreaLeave and
    -- onTriggerAreaEnter.
    if target:getLocalVar('tetherTimer') == 11 then
        xi.abyssea.searingWardTimer(target)
    end

    -- Handle Time Remaining Messages. This will no longer be called if the time
    -- remaining is less that 30s, as then we move to timers set on the player to
    -- ensure that they're displayed at the appropriate timings.
    if target:getLocalVar('finalCountdown') == 0 then
        reportTimeRemaining(target, effect)
    end
end

effectObject.onEffectLose = function(target, effect)
    local zoneID = target:getZoneID()
    local ID = zones[zoneID]

    if
        target:getLocalVar('gameLogin') == 0 and
        xi.abyssea.isInAbysseaZone(target)
    then
        target:setLocalVar('finalCountdown', 0)
        target:messageSpecial(ID.text.ABYSSEA_TIME_OFFSET + 8)
        target:startEvent(2180)
    elseif effect:getIcon() == xi.effect.VISITANT then
        -- Player exited willingly, set their time stored as seconds remaining.  Cap at 120 minutes,
        -- and remove the 4 seconds that was granted as a buffer time.
        local timeRemaining = math.min(effect:getTimeRemaining() / 1000 - 4, 7200)

        if timeRemaining < 0 then
            timeRemaining = 0
        end

        target:setCharVar('abysseaTimeStored', timeRemaining)
    end

    -- Reset Abyssea Lights
    target:setCharVar('abysseaLights1', 0)
    target:setCharVar('abysseaLights2', 0)
end

return effectObject
