-----------------------------------
-- Area: Bastok Markets
--  NPC: Malene
-- !pos -173 -5 64 235
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Quest: Wish Upon a Star
    if
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.WISH_UPON_A_STAR) == QUEST_ACCEPTED and
        player:getCharVar("WishUponAStar_Status") == 1
    then
        player:startEvent(330)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- WISH UPON A STAR
    if csid == 330 then
        player:setCharVar("WishUponAStar_Status", 2)
    end
end

return entity
