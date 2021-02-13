-----------------------------------
-- Area: Windurst Walls
--  NPC: Polikal-Ramikal
-- Working 100%
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local turmoil = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.TORAIMARAI_TURMOIL)

    if turmoil == QUEST_ACCEPTED then
        player:startEvent(391)
    else
        player:startEvent(320)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
