-----------------------------------
-- Zone: Ship_bound_for_Mhaura (221)
-----------------------------------
local ID = zones[xi.zone.SHIP_BOUND_FOR_MHAURA]
-----------------------------------
---@type TZone
local zoneObject = {}

-- Deck mob slots.
-- Entry 1 of the Sea Monk and Sea Pugil ids is the fished copy.
local slots =
{
    { id = ID.mob.SEA_CRAB[1] },
    { id = ID.mob.SEA_CRAB[2] },
    { id = ID.mob.SEA_PUGIL[2] },
    { id = ID.mob.SEA_PUGIL[3] },
    { id = ID.mob.SEA_MONK[2] },
    { id = ID.mob.SEA_HORROR },
    { id = ID.mob.PHANTOM, night = true },
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
    player:startEvent(512)
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
    if csid == 512 then
        player:setPos(0, 0, 0, 0, xi.zone.MHAURA)
    end
end

return zoneObject
