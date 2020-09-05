-----------------------------------
-- Area: Metalworks
--  NPC: Lucius
-- Involved in Mission: Bastok 3-3
-- Involved in Quest: Riding on the Clouds
-- !pos 59.959 -17.39 -42.321 237
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/missions")
local ID = require("scripts/zones/Metalworks/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_2") == 8) then
        if (trade:hasItemQty(1127, 1) and trade:getItemCount() == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_2", 0)
            player:tradeComplete()
            player:addKeyItem(tpz.ki.SMILING_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SMILING_STONE)
        end
    end

end

function onTrigger(player, npc)

    if (player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.JEUNO and player:getCharVar("MissionStatus") == 0) then
        player:startEvent(322)
    else
        player:startEvent(320)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 322) then
        player:setCharVar("MissionStatus", 1)
        player:addKeyItem(tpz.ki.LETTER_TO_THE_AMBASSADOR)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LETTER_TO_THE_AMBASSADOR)
    end

end
