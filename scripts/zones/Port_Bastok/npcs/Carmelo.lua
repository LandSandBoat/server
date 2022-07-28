-----------------------------------
-- Area: Port Bastok
--  NPC: Carmelo
-- Start & Finishes Quest: Love and Ice, A Test of True Love
-- Start Quest: Lovers in the Dusk
-- Involved in Quest: The Siren's Tear
-- !pos -146.476 -7.48 -10.889 236
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local sirensTear = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_SIRENS_TEAR)
    local loveAndIce = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVE_AND_ICE)
    local loveAndIceProgress = player:getCharVar("LoveAndIceProgress")
    local aTestOfTrueLove = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_TEST_OF_TRUE_LOVE)
    local aTestOfTrueLoveProgress = player:getCharVar("ATestOfTrueLoveProgress")
    local loversInTheDusk = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVERS_IN_THE_DUSK)

    if (loveAndIce == QUEST_AVAILABLE and sirensTear == QUEST_COMPLETED) then
        if (player:getFameLevel(xi.quest.fame_area.BASTOK) >= 5 and player:seenKeyItem(xi.ki.CARRIER_PIGEON_LETTER) == true) then
            player:startEvent(185)
        else
            player:startEvent(187)
        end
    elseif (loveAndIce == QUEST_ACCEPTED and loveAndIceProgress == 1) then
        player:startEvent(186)
    elseif (player:getFameLevel(xi.quest.fame_area.BASTOK) >= 7 and aTestOfTrueLove == QUEST_AVAILABLE and loveAndIce == QUEST_COMPLETED and player:needToZone() == false) then
        player:startEvent(270)
    elseif (aTestOfTrueLove == QUEST_ACCEPTED and aTestOfTrueLoveProgress < 3) then
        player:startEvent(271)
    elseif (aTestOfTrueLove == QUEST_ACCEPTED and aTestOfTrueLoveProgress == 3) then
        player:startEvent(272)
    elseif (aTestOfTrueLove == QUEST_ACCEPTED and aTestOfTrueLoveProgress == 4 and player:needToZone() == true) then
        player:startEvent(273)
    elseif (aTestOfTrueLove == QUEST_ACCEPTED and aTestOfTrueLoveProgress == 4 and player:needToZone() == false) then
        player:startEvent(274)
    elseif (loversInTheDusk == QUEST_AVAILABLE and aTestOfTrueLove == QUEST_COMPLETED and player:needToZone() == false) then
        player:startEvent(275)
    elseif (loversInTheDusk == QUEST_ACCEPTED) then
        player:startEvent(276)
    elseif (loversInTheDusk == QUEST_COMPLETED) then
        player:startEvent(277)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 185) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVE_AND_ICE)
        player:addKeyItem(xi.ki.CARMELOS_SONG_SHEET)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.CARMELOS_SONG_SHEET)
    elseif (csid == 186) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17356)
        else
            player:setCharVar("LoveAndIceProgress", 0)
            player:needToZone(true)
            player:addTitle(xi.title.SORROW_DROWNER)
            player:addItem(17356)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17356) -- Lamia Harp
            player:addFame(xi.quest.fame_area.BASTOK, 120)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVE_AND_ICE)
        end
    elseif (csid == 270) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_TEST_OF_TRUE_LOVE)
    elseif (csid == 272) then
        player:setCharVar("ATestOfTrueLoveProgress", 4)
        player:needToZone(true)
    elseif (csid == 274) then
        player:setCharVar("ATestOfTrueLoveProgress", 0)
        player:needToZone(true)
        player:addFame(xi.quest.fame_area.BASTOK, 120)
        player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_TEST_OF_TRUE_LOVE)
    elseif (csid == 275) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVERS_IN_THE_DUSK)
        player:addKeyItem(xi.ki.CHANSON_DE_LIBERTE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.CHANSON_DE_LIBERTE)
    end
end

return entity
