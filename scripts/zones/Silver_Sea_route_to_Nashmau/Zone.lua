-----------------------------------
-- Zone: Silver_Sea_route_to_Nashmau
-----------------------------------
local ID = zones[xi.zone.SILVER_SEA_ROUTE_TO_NASHMAU]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    -- Early return: Proteus doesn't exist.
    local proteus = GetMobByID(ID.mob.PROTEUS)
    if not proteus then
        return cs
    end

    -- Early return: Proteus can't pop yet.
    local currentTime = GetSystemTime()
    if currentTime < proteus:getLocalVar('zoneWindow') then
        return cs
    end

    -- Block multiple spawn chance rolls per boat ride.
    proteus:setLocalVar('zoneWindow', GetSystemTime() + 20)

    -- Check if Proteus pops this boat ride.
    if
        currentTime > proteus:getLocalVar('respawn') and
        math.randomInt(1, 100) <= 10
    then
        proteus:setRespawnTime(math.randomInt(120, 180)) -- 2 to 3 minutes
    end

    return cs
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportName)
    player:startEvent(1028)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 1028 then
        player:setPos(0, 0, 0, 0, xi.zone.NASHMAU)
    end
end

return zoneObject
