-----------------------------------
--
-- Zone: Sauromugue_Champaign_[S] (98)
--
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign_[S]/IDs")
require("scripts/globals/quests")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.COQUECIGRUE)
    GetMobByID(ID.mob.COQUECIGRUE):setRespawnTime(math.random(7200, 7800))
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-104, -25.36, -410, 195)
    end
    if (prevZone == tpz.zone.ROLANBERRY_FIELDS_S and player:getQuestStatus(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.DOWNWARD_HELIX) == QUEST_ACCEPTED and player:getCharVar("DownwardHelix") == 2) then
        cs = 3
    end
    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if (csid == 3) then
        player:setCharVar("DownwardHelix", 3)
    end
end

return zone_object
