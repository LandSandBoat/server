-----------------------------------
-- Area: Metalworks
--  NPC: Naji
-- Involved in Quests: The doorman (finish), Riding on the Clouds
-- Involved in Mission: Bastok 6-2
-- !pos 64 -14 -4 237
-----------------------------------
require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/titles");
require("scripts/globals/quests");
require("scripts/globals/missions");
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Metalworks/IDs");
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and
        player:getCharVar("ridingOnTheClouds_2") == 6) then
        if (trade:hasItemQty(1127, 1) and trade:getItemCount() == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_2", 0)
            player:tradeComplete()
            player:addKeyItem(xi.ki.SMILING_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SMILING_STONE)
        end
    end
end

entity.onTrigger = function(player, npc)
    if (player:hasKeyItem(xi.ki.YASINS_SWORD)) then -- The Doorman, WAR AF1
        player:startEvent(750)
    elseif (player:getCurrentMission(BASTOK) ~= xi.mission.id.bastok.NONE) then
        local currentMission = player:getCurrentMission(BASTOK)

        if (currentMission == xi.mission.id.bastok.THE_CRYSTAL_LINE and player:hasKeyItem(xi.ki.C_L_REPORTS)) then
            player:startEvent(711)
        elseif (currentMission == xi.mission.id.bastok.THE_EMISSARY and player:hasKeyItem(xi.ki.KINDRED_REPORT)) then
            player:startEvent(714)
        elseif (currentMission == xi.mission.id.bastok.THE_EMISSARY) then
            if (player:hasKeyItem(xi.ki.LETTER_TO_THE_CONSULS_BASTOK) == false and player:getMissionStatus(player:getNation()) ==
                0) then
                player:startEvent(713)
            else
                player:showText(npc, ID.text.GOOD_LUCK)
            end
        elseif (currentMission == xi.mission.id.bastok.THE_PIRATE_S_COVE and player:getMissionStatus(player:getNation()) == 0) then
            player:startEvent(761)
        elseif (currentMission == xi.mission.id.bastok.THE_PIRATE_S_COVE and player:getMissionStatus(player:getNation()) == 3) then
            player:startEvent(762)
        else
            player:startEvent(700)
        end
    end
end

-- 710  711  700  713  714  715  717  720  721  750  1008  1009  761
-- 762  782  805  845  877  938  939  940  941  942  971  969  970
entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 750) then
        if (player:getFreeSlotsCount(0) >= 1) then
            player:addItem(16678)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16678) -- Razor Axe
            player:delKeyItem(xi.ki.YASINS_SWORD)
            player:setCharVar("theDoormanCS", 0)
            player:addFame(BASTOK, 30)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DOORMAN)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16678) -- Razor Axe
        end
    elseif (csid == 713) then
        player:addKeyItem(xi.ki.LETTER_TO_THE_CONSULS_BASTOK)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LETTER_TO_THE_CONSULS_BASTOK)
        player:setMissionStatus(player:getNation(), 1)
    elseif (csid == 761) then
        player:setMissionStatus(player:getNation(), 1)
    elseif (csid == 714 or csid == 762) then
        finishMissionTimeline(player, 1, csid, option);
    end
end

return entity
