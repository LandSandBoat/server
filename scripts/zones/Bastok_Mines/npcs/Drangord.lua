-----------------------------------
-- Area: Bastok Mines
--  NPC: Drangord
-- Standard Info NPC
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.STARDUST) == QUEST_ACCEPTED then
        player:startEvent(97)
    else
        player:startEvent(21)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
