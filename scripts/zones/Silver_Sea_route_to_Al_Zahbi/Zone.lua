-----------------------------------
-- Zone: Silver_Sea_route_to_Al_Zahbi
-----------------------------------
local ID = zones[xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    -- Early return: Apkallu doesn't exist.
    local almightyapkallu = GetMobByID(ID.mob.ALMIGHTY_APKALLU)
    if not almightyapkallu then
        return cs
    end

    -- Early return: Apkallu can't pop yet.
    local currentTime = GetSystemTime()
    if currentTime < almightyapkallu:getLocalVar('zoneWindow') then
        return cs
    end

    -- Block multiple spawn chance rolls per boat ride.
    almightyapkallu:setLocalVar('zoneWindow', GetSystemTime() + 20)

    -- Check if Apkallu pops this boat ride.
    if
        currentTime > almightyapkallu:getLocalVar('respawn') and
        math.randomInt(1, 100) <= 20
    then
        almightyapkallu:setRespawnTime(math.randomInt(120, 180)) -- 2 to 3 minutes
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportName)
    player:startEvent(1028)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 1028 then
        player:setPos(0, 0, 0, 0, xi.zone.AHT_URHGAN_WHITEGATE)
    end
end

return zoneObject
