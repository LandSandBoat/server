-----------------------------------
-- Area: Port Windurst
-- NPC : Tohopka
-- Type: Standard NPC
-- !pos -105.723 -10 83.813 240
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local starStatus = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TO_CATCH_A_FALLING_STAR)

    if starStatus == QUEST_ACCEPTED then
        player:startEvent(198, 0, 546, 868)
    else
        player:startEvent(358)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
