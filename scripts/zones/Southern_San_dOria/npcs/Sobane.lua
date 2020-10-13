-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Sobane
-- Starts and Finishes Quest: Signed in Blood
-- Involved in quest: Sharpening the Sword, Riding on the Clouds
-- !pos -190 -3 97 230
-- csid: 52  732  733  734  735  736  737  738  739  740  741
-------------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    -- SIGNED IN BLOOD
    if npcUtil.tradeHas(trade, 1662) and player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.SIGNED_IN_BLOOD) == QUEST_ACCEPTED and player:getCharVar("SIGNED_IN_BLOOD_Prog") < 1 then
        player:startEvent(734, 0, 1662)

    -- RIDING ON THE CLOUDS
    elseif npcUtil.tradeHas(trade, 1127) and player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_1") == 2 then
        player:setCharVar("ridingOnTheClouds_1", 0)
        npcUtil.giveKeyItem(player, tpz.ki.SCOWLING_STONE)
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    local blood = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.SIGNED_IN_BLOOD)
    local bloodProg = player:getCharVar("SIGNED_IN_BLOOD_Prog")

    -- SHARPENING THE SWORD
    if player:getCharVar("sharpeningTheSwordCS") >= 2 then
        player:startEvent(52)

    -- SIGNED IN BLOOD
    elseif blood == QUEST_AVAILABLE and player:getFameLevel(SANDORIA) >= 3 then
        player:startEvent(732, 0, 1662) -- Start Quest
    elseif blood == QUEST_ACCEPTED and bloodProg < 1 then
        player:startEvent(733, 0, 1662)
    elseif blood == QUEST_ACCEPTED and bloodProg == 3 then
        player:startEvent(736) -- complete
    elseif blood == QUEST_ACCEPTED and bloodProg >= 1 then
        player:startEvent(735)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- SHARPENING THE SWORD
    if csid == 52 then
        player:setCharVar("sharpeningTheSwordCS", 3)

    -- SIGNED IN BLOOD
    elseif csid == 732 and option == 1 then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.SIGNED_IN_BLOOD)
    elseif csid == 734 then
        player:setCharVar("SIGNED_IN_BLOOD_Prog", 1)
    elseif csid == 736 and npcUtil.completeQuest(player, SANDORIA, tpz.quest.id.sandoria.SIGNED_IN_BLOOD, {item = 14760, gil = 3500, var = "SIGNED_IN_BLOOD_Prog"}) then
        player:delKeyItem(tpz.ki.TORN_OUT_PAGES)
        player:confirmTrade()
    end
end
