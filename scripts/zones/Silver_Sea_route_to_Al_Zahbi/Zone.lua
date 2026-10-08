-----------------------------------
-- Zone: Silver_Sea_route_to_Al_Zahbi
-----------------------------------
local ID = zones[xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI]
-----------------------------------
---@type TZone
local zoneObject = {}

-- Deck mob slots.
local slots =
{
    { id = ID.mob.APKALLU[1] },
    { id = ID.mob.APKALLU[2] },
    { id = ID.mob.BIGCLAW[1] },
    { id = ID.mob.BIGCLAW[2] },
    { id = ID.mob.CYAN_DEEP_PUGIL },
    { id = ID.mob.KULSHEDRA },
    { id = ID.mob.IMP, night = true },
    { id = ID.mob.UTUKKU, night = true },
    { id = ID.mob.AIR_ELEMENTAL, weather = { xi.weather.WIND, xi.weather.GALES } },
    { id = ID.mob.THUNDER_ELEMENTAL, weather = { xi.weather.THUNDER, xi.weather.THUNDERSTORMS } },
}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneTick = function(zone)
    xi.ferry.onZoneTick(zone, slots)
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

zoneObject.onTransportVoyageEnd = function(zone)
    xi.ferry.onTransportVoyageEnd(zone)
end

zoneObject.onZoneWeatherChange = function(weather)
    xi.ferry.onWeatherChange(weather, slots)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 1028 then
        player:setPos(0, 0, 0, 0, xi.zone.AHT_URHGAN_WHITEGATE)
    end
end

return zoneObject
