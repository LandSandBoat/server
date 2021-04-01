-----------------------------------
--
-- Zone: Aydeewa_Subterrane (68)
--
-----------------------------------
local ID = require("scripts/zones/Aydeewa_Subterrane/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, 378, -3, 338, 382, 3, 342)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(356.503, -0.364, -179.607, 122)
    end

    if player:getCurrentMission(TOAU) == xi.mission.id.toau.TEAHOUSE_TUMULT and player:getCharVar("AhtUrganStatus") == 0 then
        cs = 10
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
    if region:GetRegionID() == 1 then
        local StoneID = player:getCharVar("EmptyVesselStone")
        if player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL) == QUEST_ACCEPTED and player:getCharVar("AnEmptyVesselProgress") == 4 and player:hasItem(StoneID) then
            player:startEvent(3, StoneID)
        end
    end
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if
        csid == 3 and
        option == 13 and
        npcUtil.completeQuest(player, AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL, {title= xi.title.BEARER_OF_THE_MARK_OF_ZAHAK, ki= xi.ki.MARK_OF_ZAHAK, var={"AnEmptyVesselProgress", "EmptyVesselStone"}})
    then -- Accept and unlock
        player:unlockJob(xi.job.BLU)
        player:setPos(148, -2, 0, 130, 50)
    elseif csid == 3 and option ~= 13 then -- Make a mistake and get reset
        player:setCharVar("AnEmptyVesselProgress", 0)
        player:setCharVar("EmptyVesselStone", 0)
        player:delQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL)
        player:setPos(148, -2, 0, 130, 50)
    elseif csid == 10 then
        player:setCharVar("AhtUrganStatus", 1)
    end
end

return zone_object
