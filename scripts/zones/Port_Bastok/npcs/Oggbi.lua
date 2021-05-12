-----------------------------------
-- Area: Port Bastok (236)
--  NPC: Oggbi
-- Starts and Finishes: Ghosts of the Past, The First Meeting, The Walls of Your Mind
-- !pos -159 -7 5 236
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.GHOSTS_OF_THE_PAST) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(13122, 1) and trade:getItemCount() == 1) then -- Trade Miner's Pendant
            player:startEvent(232) -- Finish Quest "Ghosts of the Past"
        end
    end
end

entity.onTrigger = function(player, npc)
    local ghostsOfThePast = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.GHOSTS_OF_THE_PAST)
    local theFirstMeeting = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_FIRST_MEETING)
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()

    if (ghostsOfThePast == QUEST_AVAILABLE and mJob == xi.job.MNK and mLvl >= 40) then
        player:startEvent(231) -- Start Quest "Ghosts of the Past"
    elseif (ghostsOfThePast == QUEST_COMPLETED and player:needToZone() == false and theFirstMeeting == QUEST_AVAILABLE and mJob == xi.job.MNK and mLvl >= 50) then
        player:startEvent(233) -- Start Quest "The First Meeting"
    elseif (player:hasKeyItem(xi.ki.LETTER_FROM_DALZAKK) and player:hasKeyItem(xi.ki.SANDORIAN_MARTIAL_ARTS_SCROLL)) then
        player:startEvent(234) -- Finish Quest "The First Meeting"
    else
        player:startEvent(230) -- Standard Dialog
    end
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 231) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.GHOSTS_OF_THE_PAST)
    elseif (csid == 232) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17478) -- Beat Cesti
        else
            player:tradeComplete()
            player:addItem(17478)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17478) -- Beat Cesti
            player:needToZone(true)
            player:addFame(BASTOK, 20)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.GHOSTS_OF_THE_PAST)
        end
    elseif (csid == 233) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_FIRST_MEETING)
    elseif (csid == 234) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 14090) -- Temple Gaiters
        else
            player:delKeyItem(xi.ki.LETTER_FROM_DALZAKK)
            player:delKeyItem(xi.ki.SANDORIAN_MARTIAL_ARTS_SCROLL)
            player:addItem(14090)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 14090) -- Temple Gaiters
            player:addFame(BASTOK, 40)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_FIRST_MEETING)
        end
    end
end

return entity
