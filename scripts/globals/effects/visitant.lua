-----------------------------------
-- xi.effect.VISITANT
-----------------------------------
require("scripts/globals/abyssea")
require("scripts/globals/zone")
-----------------------------------
local effect_object = {}

local exitPositions =
{
    [xi.zone.ABYSSEA_KONSCHTAT]  = {   88.4, -68.09, -579.97, 128, 108 },
    [xi.zone.ABYSSEA_TAHRONGI]   = {  -28.6,  46.17,  -680.3, 192, 117 },
    [xi.zone.ABYSSEA_LA_THEINE]  = {   -562,      0,     640, 158, 102 },
    [xi.zone.ABYSSEA_ATTOHWA]    = {   -340, -23.36,   48.49,  31, 118 },
    [xi.zone.ABYSSEA_MISAREAUX]  = { 363.47,      0, -119.72, 129, 103 },
    [xi.zone.ABYSSEA_VUNKERL]    = { 242.98,   0.24,    8.72, 157, 104 },
    [xi.zone.ABYSSEA_ALTEPA]     = {    340,  -0.52,    -668, 192, 107 },
    [xi.zone.ABYSSEA_ULEGUERAND] = {    270,   -7.8,     -82,  64, 112 },
    [xi.zone.ABYSSEA_GRAUBERG]   = {    -64,      0,     600,   0, 106 },
}

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
            player:messageSpecial(ID.text.EXITING_ABYSSEA_OFFSET, messageParam / 60)
        elseif messageParam > 1 then
            player:messageSpecial(ID.text.EXITING_ABYSSEA_OFFSET + 3, messageParam)
        else
            player:messageSpecial(ID.text.EXITING_ABYSSEA_OFFSET + 2, messageParam)
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
    local zoneID = target:getZoneID()
    local ID = zones[zoneID]

    -- There are some cases where the status effect will be removed, such as
    -- transitioning from the initial five minutes to visible visitant status.
    -- If we're doing this, don't eject the player from the zone.
    if
        xi.abyssea.isInAbysseaZone(target) and
        target:getLocalVar('updatingAbysseaTime') == 0
    then
        target:setLocalVar('finalCountdown', 0)
        target:messageSpecial(ID.text.EXITING_ABYSSEA_OFFSET + 4)
        target:setPos(unpack(exitPositions[zoneID]))
    end
end

return effect_object
