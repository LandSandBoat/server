-----------------------------------
--
-- Zone: Southern_San_dOria_[S] (80)
--
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria_[S]/IDs")
require("scripts/globals/settings")
require("scripts/globals/chocobo")
require("scripts/globals/quests")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    xi.chocobo.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if prevZone == xi.zone.EAST_RONFAURE_S then
        if player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.KNOT_QUITE_THERE) == QUEST_ACCEPTED and player:getCharVar("KnotQuiteThere") == 2 then
            cs = 62
        elseif player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.DOWNWARD_HELIX) == QUEST_ACCEPTED and player:getCharVar("DownwardHelix") == 0 then
            cs = 65
        end
    end
    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(161, -2, 161, 94)
    end
    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 62 then
        player:setCharVar("KnotQuiteThere", 3)
    elseif csid == 65 then
        player:setCharVar("DownwardHelix", 1)
    end
end

return zone_object
