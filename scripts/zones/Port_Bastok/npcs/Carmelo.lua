-----------------------------------
-- Area: Port Bastok
--  NPC: Carmelo
-- Start Quest: Lovers in the Dusk
-- !pos -146.476 -7.48 -10.889 236
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local aTestOfTrueLove = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_TEST_OF_TRUE_LOVE)
    local loversInTheDusk = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVERS_IN_THE_DUSK)

    if
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
    if csid == 275 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVERS_IN_THE_DUSK)
        player:addKeyItem(xi.ki.CHANSON_DE_LIBERTE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.CHANSON_DE_LIBERTE)
    end
end

return entity
