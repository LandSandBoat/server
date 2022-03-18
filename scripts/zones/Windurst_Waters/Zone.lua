-----------------------------------
-- Zone: Windurst_Waters (238)
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/settings/main")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    -- Used for Windurst Mission 1-3
    zone:registerRegion(1, 23, -12, -208, 31, -8, -197)

    applyHalloweenNpcCostumes(zone:getID())
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    -- FIRST LOGIN (START CS)
    if player:getPlaytime(false) == 0 then
        if xi.settings.NEW_CHARACTER_CUTSCENE == 1 then
            cs = 531
        end
        player:setPos(-40, -5, 80, 64)
        player:setHomePoint()
    elseif player:getCurrentMission(COP) == xi.mission.id.cop.THE_ROAD_FORKS and player:getCharVar("MEMORIES_OF_A_MAIDEN_Status") == 1 then -- COP MEMORIES_OF_A_MAIDEN--3-3B: Windurst Route
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 2)
        cs = 871
    end

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        local position = math.random(1, 5) + 157
        player:setPos(position, -5, -62, 192)
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 531 then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
    end
end

return zone_object
