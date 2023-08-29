-----------------------------------
-- Zone: Ship_bound_for_Selbina (220)
-----------------------------------
local ID = zones[xi.zone.SHIP_BOUND_FOR_SELBINA]
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local position = math.random(-2, 2) + 0.150
        player:setPos(position, -2.100, 3.250, 64)
    end

    if
        player:hasKeyItem(xi.ki.SEANCE_STAFF) and
        player:getCharVar('Enagakure_Killed') == 0 and
        not GetMobByID(ID.mob.ENAGAKURE):isSpawned()
    then
        SpawnMob(ID.mob.ENAGAKURE)
    end

    return cs
end

zoneObject.onTransportEvent = function(player, transport)
    player:startEvent(255)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 255 then
        player:setPos(0, 0, 0, 0, 248)
    end
end

return zoneObject
