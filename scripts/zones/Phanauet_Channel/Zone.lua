-----------------------------------
-- Zone: Phanauet_Channel
-----------------------------------
local ID = zones[xi.zone.PHANAUET_CHANNEL]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneTick = function(zone)
    -- Stubborn Dredvodd has a chance to appear at any point during the barge ride
    -- once its 21-24 hour window has elapsed. The cooldown is set when it spawns
    -- (see the mob script), so a pop nobody sticks around to kill still burns the window.
    local dredvodd = GetMobByID(ID.mob.STUBBORN_DREDVODD)

    if
        not dredvodd or
        dredvodd:isSpawned() or
        GetSystemTime() < dredvodd:getLocalVar('cooldown')
    then
        return
    end

    -- He only rides the South Landing -> North Landing barge, which is the active
    -- vessel in the channel from 10:10 to 16:00 Vana'diel time.
    -- Times below let him spawn only when that barge is active.
    local vanaMinutes = VanadielHour() * 60 + VanadielMinute()
    if
        vanaMinutes < utils.timeStringToMinutes('10:30') or
        vanaMinutes >= utils.timeStringToMinutes('15:50')
    then
        return
    end

    -- Per-tick chance so the appearance is spread randomly across the ride.
    if math.randomInt(1, 100) <= 5 then
        SpawnMob(ID.mob.STUBBORN_DREDVODD)
    end
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    xi.barge.onZoneIn(player)

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local position = math.randomInt(-2, 2) + 0.15
        player:setPos(position, -2.000, -1.000, 190)
    end

    return cs
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportId)
    -- TODO: Only seen event 0 in captures but used to be 100 here. Both events have the exact same code.
    -- This might be used by SE to differentiate where to send the player?
    player:startEvent(0)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 0 then
        player:setPos(0, 0, 0, 0, xi.zone.CARPENTERS_LANDING)
    end
end

return zoneObject
