-----------------------------------
-- Area: Bastok Markets
--  NPC: Offa
-- !pos -281.628 -16.971 -140.607 235
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local smokeOnTheMountain = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.SMOKE_ON_THE_MOUNTAIN)
    if smokeOnTheMountain == QUEST_ACCEPTED then
        player:startEvent(222)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
