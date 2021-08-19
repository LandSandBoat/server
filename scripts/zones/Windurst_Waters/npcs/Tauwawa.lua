-----------------------------------
-- Area: Windurst Waters
--  NPC: Tauwawa
-- Working 100%
-----------------------------------
require("scripts/globals/quests")
require("scripts/settings/main")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_THE_GRADE) == QUEST_ACCEPTED then
        player:startEvent(446)
    else
        player:startEvent(424)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
