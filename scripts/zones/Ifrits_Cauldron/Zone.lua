-----------------------------------
-- Zone: Ifrits_Cauldron (205)
-----------------------------------
local ID = zones[xi.zone.IFRITS_CAULDRON]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.ASH_DRAGON)
    GetMobByID(ID.mob.ASH_DRAGON):setRespawnTime(math.random(900, 10800))

    xi.treasure.initZone(zone)
    xi.helm.initZone(zone, xi.helmType.MINING)
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
        player:setPos(100, 0, -320, 188)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameHour = function(zone)
    -- Opens flame spouts every 3 hours Vana'diel time. Doors are offset from spouts by 5.
    if VanadielHour() % 3 == 0 then
        for i = 5, 8 do
            GetNPCByID(ID.npc.FLAME_SPOUT_OFFSET + i):openDoor(90)
        end
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
