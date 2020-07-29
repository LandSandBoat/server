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


function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local SirensTear = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_SIREN_S_TEAR)
    local SirensTearProgress = player:getCharVar("SirensTear")
    local TheStarsOfIfrit = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_STARS_OF_IFRIT)
    local LoveAndIce = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LOVE_AND_ICE)
    local LoveAndIceProgress = player:getCharVar("LoveAndIceProgress")
    local ATestOfTrueLove = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.A_TEST_OF_TRUE_LOVE)
    local ATestOfTrueLoveProgress = player:getCharVar("ATestOfTrueLoveProgress")
    local LoversInTheDusk = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LOVERS_IN_THE_DUSK)

    if (SirensTear == QUEST_ACCEPTED) then
        player:startEvent(6)
    elseif (SirensTear == QUEST_COMPLETED and player:hasItem(576) == false and SirensTearProgress < 2) then
        player:startEvent(19)
    elseif (LoveAndIce == QUEST_AVAILABLE and SirensTear == QUEST_COMPLETED and SirensTear == QUEST_COMPLETED) then
        if (player:getFameLevel(BASTOK) >= 5 and player:seenKeyItem(tpz.ki.CARRIER_PIGEON_LETTER) == true) then
            player:startEvent(185)
        else
            player:startEvent(187)
        end
    elseif (LoveAndIce == QUEST_ACCEPTED and LoveAndIceProgress == 1) then
        player:startEvent(186)
    elseif (player:getFameLevel(BASTOK) >= 7 and ATestOfTrueLove == QUEST_AVAILABLE and LoveAndIce == QUEST_COMPLETED and player:needToZone() == false) then
        player:startEvent(270)
    elseif (ATestOfTrueLove == QUEST_ACCEPTED and ATestOfTrueLoveProgress < 3) then
        player:startEvent(271)
    elseif (ATestOfTrueLove == QUEST_ACCEPTED and ATestOfTrueLoveProgress == 3) then
        player:startEvent(272)
    elseif (ATestOfTrueLove == QUEST_ACCEPTED and ATestOfTrueLoveProgress == 4 and player:needToZone() == true) then
        player:startEvent(273)
    elseif (ATestOfTrueLove == QUEST_ACCEPTED and ATestOfTrueLoveProgress == 4 and player:needToZone() == false) then
        player:startEvent(274)
    elseif (LoversInTheDusk == QUEST_AVAILABLE and ATestOfTrueLove == QUEST_COMPLETED and player:needToZone() == false) then
        player:startEvent(275)
    elseif (LoversInTheDusk == QUEST_ACCEPTED) then
        player:startEvent(276)
    elseif (LoversInTheDusk == QUEST_COMPLETED) then
        player:startEvent(277)
    else
        player:startEvent(182)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 6) then
        player:setCharVar("SirensTear", 1)
    elseif (csid == 19) then
        player:setCharVar("SirensTear", 2)
    elseif (csid == 185) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.LOVE_AND_ICE)
        player:addKeyItem(tpz.ki.CARMELOS_SONG_SHEET)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CARMELOS_SONG_SHEET)
    elseif (csid == 186) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17356)
        else
            player:setCharVar("LoveAndIceProgress", 0)
            player:needToZone(true)
            player:addTitle(tpz.title.SORROW_DROWNER)
            player:addItem(17356)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17356) -- Lamia Harp
            player:addFame(BASTOK, 120)
            player:completeQuest(BASTOK, tpz.quest.id.bastok.LOVE_AND_ICE)
        end
    elseif (csid == 270) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.A_TEST_OF_TRUE_LOVE)
    elseif (csid == 272) then
        player:setCharVar("ATestOfTrueLoveProgress", 4)
        player:needToZone(true)
    elseif (csid == 274) then
        player:setCharVar("ATestOfTrueLoveProgress", 0)
        player:needToZone(true)
        player:addFame(BASTOK, 120)
        player:completeQuest(BASTOK, tpz.quest.id.bastok.A_TEST_OF_TRUE_LOVE)
    elseif (csid == 275) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.LOVERS_IN_THE_DUSK)
        player:addKeyItem(tpz.ki.CHANSON_DE_LIBERTE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CHANSON_DE_LIBERTE)
    end
end
