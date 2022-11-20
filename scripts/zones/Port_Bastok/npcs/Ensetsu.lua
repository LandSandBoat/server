-----------------------------------
-- Area: Port Bastok
--  NPC: Ensetsu
-- Finish Quest: Ayame and Kaede
-- Involved in Quest: 20 in Pirate Years, I'll Take the Big Box
-- !pos 33 -6 67 236
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local ayameAndKaede = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.AYAME_AND_KAEDE)

    if ayameAndKaede == QUEST_ACCEPTED then
        local questStatus = player:getCharVar("AyameAndKaede_Event")

        if
            (questStatus == 1 or questStatus == 2) and
            not player:hasKeyItem(xi.ki.STRANGELY_SHAPED_CORAL)
        then
            player:startEvent(242)
        elseif questStatus == 2 and player:hasKeyItem(xi.ki.STRANGELY_SHAPED_CORAL) then
            player:startEvent(245)
        elseif questStatus == 3 then
            player:startEvent(243)
        elseif player:hasKeyItem(xi.ki.SEALED_DAGGER) then
            player:startEvent(246, xi.ki.SEALED_DAGGER)
        else
            player:startEvent(27)
        end
    elseif
        ayameAndKaede == QUEST_COMPLETED and
        player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TWENTY_IN_PIRATE_YEARS) == QUEST_AVAILABLE
    then
        player:startEvent(247)
    elseif player:getCharVar("twentyInPirateYearsCS") == 2 then
        player:startEvent(262)
    elseif player:getCharVar("twentyInPirateYearsCS") == 4 then
        player:startEvent(263)
    elseif
        player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX) == QUEST_ACCEPTED and
        player:getCharVar("illTakeTheBigBoxCS") == 0
    then
        player:startEvent(264)
    elseif player:getCharVar("illTakeTheBigBoxCS") == 1 then
        player:startEvent(265)
    else
        player:startEvent(27)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 242 then
        player:setCharVar("AyameAndKaede_Event", 2)
    elseif csid == 245 then
        player:setCharVar("AyameAndKaede_Event", 3)
    elseif csid == 246 then
        player:delKeyItem(xi.ki.SEALED_DAGGER)
        player:addTitle(xi.title.SHADOW_WALKER)
        player:unlockJob(xi.job.NIN)
        player:messageSpecial(ID.text.UNLOCK_NINJA)
        player:setCharVar("AyameAndKaede_Event", 0)
        player:addFame(xi.quest.fame_area.BASTOK, 30)
        player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.AYAME_AND_KAEDE)
    elseif csid == 262 then
        player:setCharVar("twentyInPirateYearsCS", 3)
    elseif csid == 264 then
        player:setCharVar("illTakeTheBigBoxCS", 1)
    end
end

return entity
