-----------------------------------
-- xi.effect.VISITANT
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local effect_object = {}

local remainingTimeLimits =
{
    300,
    120,
     60,
     30,
     10,
      9,
      8,
      7,
      6,
      5,
      4,
      3,
      2,
      1,
}

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
    if
        currentTime > lastTimeUpdate
    then
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
            player:messageSpecial(ID.text.EXITING_IN_MINUTES, messageParam / 60)
        elseif messageParam > 1 then
            player:messageSpecial(ID.text.EXITING_IN_MINS_SECS, messageParam)
        else
            player:messageSpecial(ID.text.EXITING_IN_MIN_SEC, messageParam)
        end
    end

    -- Handle the more granular countdown, as effect ticks are only every
    -- three seconds.
    if player:getLocalVar('finalCountdown') == 1 then
        if messageParam > 0 then
            local timerVal = (messageParam - nextTimeReport) * 1000

            player:timer(timerVal, function() reportTimeRemaining(player, effect) end)
        else
            -- There's 4s of buffer time built in, so that the full countdown is displayed.
            -- If we reached the end, delete the status effect so that the player is ejected.
            player:delStatusEffectSilent(xi.effect.VISITANT)
        end
    end
end

effect_object.onEffectGain = function(target, effect)
    local visEffect = target:getStatusEffect(xi.effect.VISITANT)

    visEffect:setFlag(xi.effectFlag.OFFLINE_TICK)
    visEffect:setFlag(xi.effectFlag.NO_CANCEL)
    visEffect:setFlag(xi.effectFlag.ON_ZONE)
    visEffect:setFlag(xi.effectFlag.INFLUENCE)

    target:setLocalVar('lastTimeUpdate', effect:getTimeRemaining() / 1000 + 1)
end

effect_object.onEffectTick = function(target, effect)
	if not xi.abyssea.isInAbysseaZone(target) then
        target:delStatusEffect(effect)
    end

    -- Searing Ward Tether is set and reset in zone onRegionLeave and
    -- onRegionEnter.
    if target:getLocalVar('tetherTimer') == 11 then
        xi.abyssea.searingWardTimer(target)
    end

    -- Handle Time Remaining Messages. This will no longer be called if the time
    -- remaining is less that 30s, as then we move to timers set on the player to
    -- ensure that they're displayed at the appropriate timings.
    if
        target:getLocalVar('finalCountdown') == 0
    then
        reportTimeRemaining(target, effect)
    end
end

effect_object.onEffectLose = function(target, effect)
    local ID = zones[target:getZoneID()]

    -- There are some cases where the status effect will be removed, such as
    -- transitioning from the initial five minutes to visible visitant status.
    -- If we're doing this, don't eject the player from the zone.
    if
        xi.abyssea.isInAbysseaZone(target) and
        target:getLocalVar('updatingAbysseaTime') == 0
    then
        target:setLocalVar('finalCountdown', 0)
        target:messageSpecial(ID.text.EXITING_NOW)
        target:setPos(-340, -23.4, 48.5, 31, 118)
    end
end

return effect_object
