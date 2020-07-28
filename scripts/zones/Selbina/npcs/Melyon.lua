-----------------------------------
-- Area: Selbina
--  NPC: Melyon
-- Starts and Finishes Quest: Only the Best (R)
-- Involved in Quest: Riding on the Clouds
-- !pos 25 -6 6 248
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if
        player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and
        player:getCharVar("ridingOnTheClouds_3") == 3 and
        npcUtil.tradeHas(trade, 1127)
    then
        player:setCharVar("ridingOnTheClouds_3", 0)
        npcUtil.giveKeyItem(player, tpz.ki.SOMBER_STONE)
        player:confirmTrade()

    elseif player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.ONLY_THE_BEST) ~= QUEST_AVAILABLE then
        if npcUtil.tradeHas(trade, {{4366, 5}}) then -- La Theine Cabbage x5
            player:startEvent(62)
        elseif npcUtil.tradeHas(trade, {{629, 3}}) then -- Millioncorn x3
            player:startEvent(63)
        elseif npcUtil.tradeHas(trade, 919) then -- Boyahda Moss x1
            player:startEvent(64)
        end
    end
end

function onTrigger(player, npc)
    if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.ONLY_THE_BEST) == QUEST_AVAILABLE then
        player:startEvent(60, 4366, 629, 919) -- Start quest "Only the Best"
    else
        player:startEvent(61, 4366, 629, 919) -- During & after completed quest "Only the Best"
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 60 and option == 10 then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.ONLY_THE_BEST)
    elseif csid == 62 then
        player:addGil(100)
        player:messageSpecial(ID.text.GIL_OBTAINED, 100)
        player:addFame(BASTOK, 10)
        player:addFame(SANDORIA, 10)
        player:addFame(JEUNO, 10)
        player:completeQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.ONLY_THE_BEST)
        player:confirmTrade()
    elseif (csid == 63) then
        player:addGil(120)
        player:messageSpecial(ID.text.GIL_OBTAINED, 120)
        player:addFame(BASTOK, 20)
        player:addFame(SANDORIA, 20)
        player:addFame(JEUNO, 20)
        player:completeQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.ONLY_THE_BEST)
        player:confirmTrade()
    elseif (csid == 64) then
        player:addGil(600)
        player:messageSpecial(ID.text.GIL_OBTAINED, 600)
        player:addFame(BASTOK, 30)
        player:addFame(SANDORIA, 30)
        player:addFame(JEUNO, 30)
        player:completeQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.ONLY_THE_BEST)
        player:confirmTrade()
    end
end
