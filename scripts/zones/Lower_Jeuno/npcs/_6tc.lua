-----------------------------------
-- Area: Lower Jeuno
--  NPC: Door: "Neptune's Spire"
-- Starts and Finishes Quest: Beat Around the Bushin
-- !pos 35 0 -15 245
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
require("scripts/globals/missions")
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEAT_AROUND_THE_BUSHIN) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(1526, 1) == true and trade:getItemCount() == 1 and player:getCharVar("BeatAroundTheBushin") == 2) then
            player:startEvent(156) -- After trade Wyrm Beard
        elseif (trade:hasItemQty(1527, 1) == true and trade:getItemCount() == 1 and player:getCharVar("BeatAroundTheBushin") == 4) then
            player:startEvent(157) -- After trade Behemoth Tongue
        elseif (trade:hasItemQty(1525, 1) == true and trade:getItemCount() == 1 and player:getCharVar("BeatAroundTheBushin") == 6) then
            player:startEvent(158) -- After trade Adamantoise Egg
        elseif (trade:hasItemQty(13202, 1) == true and trade:getItemCount() == 1 and player:getCharVar("BeatAroundTheBushin") == 7) then
            player:startEvent(159) -- After trade Brown Belt, Finish Quest "Beat around the Bushin"
        end
    end
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(COP) == xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN and player:getCharVar("PromathiaStatus") == 0) then
        player:startEvent(86) --COP event
    elseif (player:getCurrentMission(COP) == xi.mission.id.cop.TENDING_AGED_WOUNDS and player:getCharVar("PromathiaStatus")==1) then
        player:startEvent(22) --COP event
    elseif (player:getCharVar("BeatAroundTheBushin") == 1) then
        player:startEvent(155) -- Start Quest "Beat around the Bushin"
    elseif (player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) == true) then
        player:startEvent(105) -- Open the door
    else
        player:messageSpecial(ID.text.ITS_LOCKED)
        return 1
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 86 ) then
        player:setCharVar("PromathiaStatus", 1)
        player:startEvent(9)
    elseif (csid == 22 ) then
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.TENDING_AGED_WOUNDS)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED)
        player:setCharVar("PromathiaStatus", 0)
        player:startEvent(10)
    elseif (csid == 155) then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEAT_AROUND_THE_BUSHIN)
        player:setCharVar("BeatAroundTheBushin", 2)
    elseif (csid == 156) then
        player:setCharVar("BeatAroundTheBushin", 3)
        player:tradeComplete()
    elseif (csid == 157) then
        player:setCharVar("BeatAroundTheBushin", 5)
        player:tradeComplete()
    elseif (csid == 158) then
        player:setCharVar("BeatAroundTheBushin", 7)
        player:tradeComplete()
    elseif (csid == 159) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13186)
        else
            player:addTitle(xi.title.BLACK_BELT)
            player:addItem(13186)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13186)
            player:setCharVar("BeatAroundTheBushin", 0)
            player:addFame(NORG, 125)
            player:tradeComplete()
            player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEAT_AROUND_THE_BUSHIN)
        end
    end
end

return entity
