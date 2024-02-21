-----------------------------------
-- Zone: Xarcabard_[S] (137)
-----------------------------------
local ID = zones[xi.zone.XARCABARD_S]
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    GetMobByID(ID.mob.ZIRNITRA):setRespawnTime(math.random(14400, 18000))
    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-414, -46.5, 20, 253)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
