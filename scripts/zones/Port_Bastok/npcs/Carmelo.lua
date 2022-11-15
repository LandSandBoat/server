-----------------------------------
-- Area: Port Bastok
--  NPC: Carmelo
-- Start & Finishes Quest: A Test of True Love
-- Start Quest: Lovers in the Dusk
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
    local loveAndIce = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVE_AND_ICE)
    local aTestOfTrueLove = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_TEST_OF_TRUE_LOVE)
    local aTestOfTrueLoveProgress = player:getCharVar("ATestOfTrueLoveProgress")
    local loversInTheDusk = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVERS_IN_THE_DUSK)

    if
        player:getFameLevel(xi.quest.fame_area.BASTOK) >= 7 and
        aTestOfTrueLove == QUEST_AVAILABLE and
        loveAndIce == QUEST_COMPLETED and
        not player:needToZone()
    then
        player:startEvent(270)
    elseif aTestOfTrueLove == QUEST_ACCEPTED and aTestOfTrueLoveProgress < 3 then
        player:startEvent(271)
    elseif aTestOfTrueLove == QUEST_ACCEPTED and aTestOfTrueLoveProgress == 3 then
        player:startEvent(272)
    elseif
        aTestOfTrueLove == QUEST_ACCEPTED and
        aTestOfTrueLoveProgress == 4 and
        player:needToZone()
    then
        player:startEvent(273)
    elseif
        aTestOfTrueLove == QUEST_ACCEPTED and
        aTestOfTrueLoveProgress == 4 and
        not player:needToZone()
    then
        player:startEvent(274)
    elseif
        loversInTheDusk == QUEST_AVAILABLE and
        aTestOfTrueLove == QUEST_COMPLETED and
        not player:needToZone()
    then
        player:startEvent(275)
    elseif loversInTheDusk == QUEST_ACCEPTED then
        player:startEvent(276)
    elseif loversInTheDusk == QUEST_COMPLETED then
        player:startEvent(277)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 270 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_TEST_OF_TRUE_LOVE)
    elseif csid == 272 then
        player:setCharVar("ATestOfTrueLoveProgress", 4)
        player:needToZone(true)
    elseif csid == 274 then
        player:setCharVar("ATestOfTrueLoveProgress", 0)
        player:needToZone(true)
        player:addFame(xi.quest.fame_area.BASTOK, 120)
        player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_TEST_OF_TRUE_LOVE)
    elseif csid == 275 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVERS_IN_THE_DUSK)
        player:addKeyItem(xi.ki.CHANSON_DE_LIBERTE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.CHANSON_DE_LIBERTE)
    end
end

return entity
