-----------------------------------
-- Zone: Castle_Zvahl_Baileys (161)
-----------------------------------
local ID = require('scripts/zones/Castle_Zvahl_Baileys/IDs')
require('scripts/globals/conquest')
require('scripts/globals/treasure')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Trigger Areas
    zone:registerTriggerArea(1, -90, 17, 45, -84, 19, 51)  -- map 4 NW porter
    zone:registerTriggerArea(1, 17, -90, 45, -85, 18, 51)  -- map 4 NW porter
    zone:registerTriggerArea(2, -90, 17, -10, -85, 18, -5)  -- map 4 SW porter
    zone:registerTriggerArea(3, -34, 17, -10, -30, 18, -5)  -- map 4 SE porter
    zone:registerTriggerArea(4, -34, 17, 45, -30, 18, 51)  -- map 4 NE porter

    -- NM Persistence
    if xi.settings.main.ENABLE_WOTG == 1 then
        xi.mob.nmTODPersistCache(zone, ID.mob.LIKHO)
    end

    xi.mob.nmTODPersistCache(zone, ID.mob.MARQUIS_ALLOCEN)
    xi.mob.nmTODPersistCache(zone, ID.mob.MARQUIS_AMON)
    xi.mob.nmTODPersistCache(zone, ID.mob.DUKE_HABORYM)
    xi.mob.nmTODPersistCache(zone, ID.mob.GRAND_DUKE_BATYM)

    -- Treasure Initiation
    xi.treasure.initZone(zone)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
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
    local areaId = triggerArea:GetTriggerAreaID()

    if teleportEventsByArea[areaId] then
        player:startEvent(teleportEventsByArea[areaId])
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
