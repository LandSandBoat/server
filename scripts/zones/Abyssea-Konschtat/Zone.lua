-----------------------------------
--
-- Zone: Abyssea - Konschtat
--
-----------------------------------
-- Research
-- EventID 1024-1029 aura of boundless rage
-- EventID 2048-2179 The treasure chest will disappear is 180 seconds menu.
-- EventID 2180 Teleport?
-- EventID 2181 DEBUG Menu
-----------------------------------
local ID = require("scripts/zones/Abyssea-Konschtat/IDs")
require("scripts/globals/quests")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    -- Note: in retail even tractor lands you back at searing ward, will handle later.
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(153, -72, -840, 140)
    end

    if player:getQuestStatus(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.THE_TRUTH_BECKONS) == QUEST_ACCEPTED and player:getCharVar("1stTimeAbyssea") == 0 then
        player:setCharVar("1stTimeAbyssea", 1)
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
