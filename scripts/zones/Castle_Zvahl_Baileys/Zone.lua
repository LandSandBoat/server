-----------------------------------
-- Zone: Castle_Zvahl_Baileys (161)
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_BAILEYS]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, -90, 17, 45, -84, 19, 51)  -- map 4 NW porter
    zone:registerCuboidTriggerArea(1, 17, -90, 45, -85, 18, 51)  -- map 4 NW porter
    zone:registerCuboidTriggerArea(2, -90, 17, -10, -85, 18, -5)  -- map 4 SW porter
    zone:registerCuboidTriggerArea(3, -34, 17, -10, -30, 18, -5)  -- map 4 SE porter
    zone:registerCuboidTriggerArea(4, -34, 17, 45, -30, 18, 51)  -- map 4 NE porter

    UpdateNMSpawnPoint(ID.mob.LIKHO)
    GetMobByID(ID.mob.LIKHO):setRespawnTime(math.random(3600, 4200))

    UpdateNMSpawnPoint(ID.mob.MARQUIS_ALLOCEN)
    GetMobByID(ID.mob.MARQUIS_ALLOCEN):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.MARQUIS_AMON)
    GetMobByID(ID.mob.MARQUIS_AMON):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.DUKE_HABORYM)
    GetMobByID(ID.mob.DUKE_HABORYM):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.GRAND_DUKE_BATYM)
    GetMobByID(ID.mob.GRAND_DUKE_BATYM):setRespawnTime(math.random(900, 10800))

    xi.treasure.initZone(zone)
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
        player:setPos(-181.969, -35.542, 19.995, 254)
    end

    return cs
end

local teleportEventsByArea =
{
    [1] = 3, -- Teleports player to NW room of map 3
    [2] = 2, -- Teleports player to SW room of map 3
    [3] = 1, -- Teleports player to SE room of map 3
    [4] = 0, -- Teleports player to NE room of map 3
}

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local areaId = triggerArea:getTriggerAreaID()

    if teleportEventsByArea[areaId] then
        player:startEvent(teleportEventsByArea[areaId])
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
