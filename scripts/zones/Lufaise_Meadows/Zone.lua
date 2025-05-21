-----------------------------------
-- Zone: Lufaise_Meadows (24)
-----------------------------------
local ID = zones[xi.zone.LUFAISE_MEADOWS]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, 179, -26, 327, 219, -18, 347)

    SetServerVariable('realPadfoot', math.random(1, 5))
    for _, v in pairs(ID.mob.PADFOOT) do
        SpawnMob(v)
    end

    xi.conquest.setRegionalConquestOverseers(zone:getRegionID())

    GetMobByID(ID.mob.FLOCKBOCK):setRespawnTime(math.random(3600, 7200))

    xi.helm.initZone(zone, xi.helmType.LOGGING)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(458, 6, -4, 82)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
