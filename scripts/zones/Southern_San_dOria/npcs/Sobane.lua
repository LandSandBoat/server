-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Sobane
-- Starts and Finishes Quest: Signed in Blood, Tea with a Tonberry
-- Involved in quest: Sharpening the Sword, Riding on the Clouds
-- !pos -190 -3 97 230
-- csid: 52  732  733  734  735  736  737  738  739  740  741
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- RIDING ON THE CLOUDS
    if npcUtil.tradeHas(trade, 1127) and player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_1") == 2 then
        player:setCharVar("ridingOnTheClouds_1", 0)
        npcUtil.giveKeyItem(player, xi.ki.SCOWLING_STONE)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    -- SHARPENING THE SWORD
    if player:getCharVar("sharpeningTheSwordCS") >= 2 then
        player:startEvent(52)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- SHARPENING THE SWORD
    if csid == 52 then
        player:setCharVar("sharpeningTheSwordCS", 3)
    end
end

return entity
