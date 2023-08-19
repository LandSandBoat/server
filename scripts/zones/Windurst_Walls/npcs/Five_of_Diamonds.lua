-----------------------------------
-- Area: Windurst Walls
--  NPC: Five of Diamonds
-- !pos -220.954 -0.001 -122.708 239
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.A_GREETING_CARDIAN) == QUEST_ACCEPTED then
        player:startEvent(339)
    else
        player:startEvent(266)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
