-----------------------------------
-- Zone: Open_sea_route_to_Mhaura (47)
-----------------------------------
local ID = zones[xi.zone.OPEN_SEA_ROUTE_TO_MHAURA]
-----------------------------------
---@type TZone
local zoneObject = {}

-- Deck mob slots.
local slots =
{
    { id = ID.mob.GUGRU_CRAB[1] },
    { id = ID.mob.GUGRU_CRAB[2] },
    { id = ID.mob.OCEAN_JAGIL[1] },
    { id = ID.mob.OCEAN_JAGIL[2] },
    { id = ID.mob.OCEAN_KRAKEN },
    { id = ID.mob.REVENANT, night = true },
    { id = ID.mob.THUNDER_ELEMENTAL, weather = { xi.weather.THUNDER, xi.weather.THUNDERSTORMS } },
    { id = ID.mob.WATER_ELEMENTAL, weather = { xi.weather.RAIN, xi.weather.SQUALL } },
}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneTick = function(zone)
    xi.ferry.onZoneTick(zone, slots)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local position = math.randomInt(-2, 2) + 0.150
        player:setPos(position, -2.100, 3.250, 64)
    end

    return cs
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportName)
    player:startEvent(1028)
    player:messageSpecial(ID.text.DOCKING_IN_MHAURA)
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
        player:setPos(0, 0, 0, 0, xi.zone.MHAURA)
    end
end

return zoneObject
