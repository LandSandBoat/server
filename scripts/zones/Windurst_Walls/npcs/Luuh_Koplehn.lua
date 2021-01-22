-----------------------------------
-- Area: Windurst Walls
--  NPC: Luuh Koplehn
-- Standard Info NPC
-- !pos -93 -5 130 239
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local qStarStruck = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.STAR_STRUCK)

    if (qStarStruck == QUEST_ACCEPTED) then
        player:startEvent(200)
    else
        player:startEvent(322)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
