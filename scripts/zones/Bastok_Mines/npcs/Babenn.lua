-----------------------------------
-- Area: Bastok Mines
--  NPC: Babenn
-- Finishes Quest: The Eleventh's Hour
-- Involved in Quests: Riding on the Clouds
-- !pos 73 -1 34 234
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_2") == 1) then
        if (trade:hasItemQty(1127, 1) and trade:getItemCount() == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_2", 0)
            player:tradeComplete()
            player:addKeyItem(tpz.ki.SMILING_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SMILING_STONE)
        end
    end

end

function onTrigger(player, npc)

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_ELEVENTH_S_HOUR) == QUEST_ACCEPTED and player:getCharVar("EleventhsHour") == 1) then
        player:startEvent(45)
    else
        player:startEvent(40)
    end

end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)

    if (csid == 45) then

        if (player:getFreeSlotsCount() > 1) then
            player:setCharVar("EleventhsHour", 0)
            player:delKeyItem(tpz.ki.OLD_TOOLBOX)
            player:addTitle(tpz.title.PURSUER_OF_THE_TRUTH)
            player:addItem(16629)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16629)
            player:addFame(BASTOK, 30)
            player:completeQuest(BASTOK, tpz.quest.id.bastok.THE_ELEVENTH_S_HOUR)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16629)
        end
    end
end
