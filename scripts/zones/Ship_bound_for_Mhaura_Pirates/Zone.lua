-----------------------------------
-- Zone: Ship_bound_for_Mhaura_Pirates (228)
-----------------------------------
local ID = zones[xi.zone.SHIP_BOUND_FOR_MHAURA_PIRATES]
-----------------------------------
---@type TZone
local zoneObject = {}

-- The first Sea Monk and Sea Pugil IDs are for fishing.
local slots =
{
    { id = ID.mob.SEA_CRAB[1] },
    { id = ID.mob.SEA_CRAB[2] },
    { id = ID.mob.SEA_PUGIL[2] },
    { id = ID.mob.SEA_PUGIL[3] },
    { id = ID.mob.SEA_MONK[2] },
    { id = ID.mob.PHANTOM, night = true },
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
    -- don't take action on pirate ship transport departure
    if prevZoneId > 0 then
        player:startEvent(512)
    end
end

zoneObject.onTransportVoyageEnd = function(zone)
    zone:setLocalVar('nmCanSpawn', 0)
    xi.ferry.onTransportVoyageEnd(zone)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 512 then
        player:setPos(0, 0, 0, 0, xi.zone.MHAURA)
    end
end

return zoneObject
