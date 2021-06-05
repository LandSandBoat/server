-----------------------------------
-- Area: Windurst Walls
--  NPC: Yoran-Oran
-- Type: Standard NPC
-- !pos -109.987 -14 203.338 239
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MANDRAGORA_MAD) ~= QUEST_AVAILABLE then
        if npcUtil.tradeHas(trade, 17344, true) then
            player:startEvent(251, GIL_RATE*200)
        elseif npcUtil.tradeHas(trade, 934, true) then
            player:startEvent(252, GIL_RATE*250)
        elseif npcUtil.tradeHas(trade, 1154, true) then
            player:startEvent(253, GIL_RATE*1200)
        elseif npcUtil.tradeHas(trade, 4369, true) then
            player:startEvent(254, GIL_RATE*120)
        elseif npcUtil.tradeHas(trade, 1150, true) then
            player:startEvent(255, GIL_RATE*5500)
        else
            player:startEvent(250)
        end
    end
end

entity.onTrigger = function(player, npc)
    local MandragoraMad = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MANDRAGORA_MAD)
    local blastFromPast = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLAST_FROM_THE_PAST)
    local turmoil = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)
    local MEMORIES_OF_A_MAIDEN = player:getCharVar("MEMORIES_OF_A_MAIDEN_Status")
    local LouverancePath = player:getCharVar("COP_Louverance_s_Path")
    local missionStatus = player:getMissionStatus(player:getNation())

    --optional windy 9-1
    if player:getCurrentMission(WINDURST) == xi.mission.id.windurst.DOLL_OF_THE_DEAD and missionStatus == 4 then
        player:startEvent(439, 0, 17868, 1181)
    elseif player:getCurrentMission(COP) == xi.mission.id.cop.THE_ROAD_FORKS and MEMORIES_OF_A_MAIDEN == 3 then
        player:startEvent(469)
    elseif player:getCurrentMission(COP) == xi.mission.id.cop.THE_ROAD_FORKS and MEMORIES_OF_A_MAIDEN == 6 then
        player:startEvent(470, 0, 587, 581, 586)
    elseif player:getCurrentMission(COP) == xi.mission.id.cop.THE_ROAD_FORKS and player:hasKeyItem(xi.ki.MIMEO_FEATHER) then
        player:startEvent(471)
    elseif player:getCurrentMission(COP) == xi.mission.id.cop.THE_ROAD_FORKS and MEMORIES_OF_A_MAIDEN == 11 then
        player:startEvent(472)
    elseif player:getCurrentMission(COP) == xi.mission.id.cop.THREE_PATHS and LouverancePath == 3 then
        player:startEvent(481)
    elseif player:getCurrentMission(COP) == xi.mission.id.cop.THREE_PATHS and player:getCharVar("COP_Ulmia_s_Path") == 4 then
        player:startEvent(473)
    elseif blastFromPast == QUEST_ACCEPTED then
        local blastPastProg = player:getCharVar("BlastFromThePast_Prog")
        if (blastPastProg == 1) then
            player:startEvent(221)
            player:setCharVar("BlastFromThePast_Prog", 2)
        elseif (blastPastProg == 2) then
            player:startEvent(222)
        end
    elseif blastFromPast == QUEST_COMPLETED and player:needToZone() == true then
        player:startEvent(223)
    elseif MandragoraMad == QUEST_AVAILABLE then
        player:startEvent(249)
    elseif MandragoraMad == QUEST_ACCEPTED then
        player:startEvent(256)
    elseif turmoil == QUEST_ACCEPTED then
        player:startEvent(392)
    else
        player:startEvent(245)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 249 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MANDRAGORA_MAD)
    elseif csid == 469 then
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 4)
    elseif csid == 470 then
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 7)
        player:delKeyItem(xi.ki.CRACKED_MIMEO_MIRROR)
    elseif csid == 471 then
        player:delKeyItem(xi.ki.MIMEO_FEATHER)
        player:delKeyItem(xi.ki.SECOND_MIMEO_FEATHER)
        player:delKeyItem(xi.ki.THIRD_MIMEO_FEATHER)
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 9)
    elseif csid == 472 then
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 12)    --end 3-3B: Windurst Route: "Memories of a Maiden"
    elseif csid == 481 then
        player:setCharVar("COP_Louverance_s_Path", 4)
    elseif csid == 473 then
        player:setCharVar("COP_Ulmia_s_Path", 5)
    elseif csid == 439 then
        player:setMissionStatus(player:getNation(), 5)
    elseif csid == 251 then
        npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.MANDRAGORA_MAD, { fame = 10 })
        player:addGil(GIL_RATE*200)
        player:confirmTrade()
    elseif csid == 252 then
        npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.MANDRAGORA_MAD, { fame = 25 })
        player:addGil(GIL_RATE*250)
        player:confirmTrade()
    elseif csid == 253 then
        npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.MANDRAGORA_MAD, { fame = 50 })
        player:addGil(GIL_RATE*1200)
        player:confirmTrade()
    elseif csid == 254 then
        npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.MANDRAGORA_MAD, { fame = 10 })
        player:addGil(GIL_RATE*120)
        player:confirmTrade()
    elseif csid == 255 then
        npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.MANDRAGORA_MAD, { fame = 100 })
        player:addGil(GIL_RATE*5500)
        player:confirmTrade()
    end
end

return entity
