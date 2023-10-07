-----------------------------------
-- Area: Windurst Walls
--  NPC: Koru-Moru
-- Starts & Ends Quest: Star Struck
-- Involved in Quest: Making the Grade, Riding on the Clouds
-- !pos -120 -6 124 239
-----------------------------------
local ID = require("scripts/zones/Windurst_Walls/IDs")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}
entity.onTrade = function(player, npc, trade)
    local count = trade:getItemCount()

    if trade:hasItemQty(829, 1) and count == 1 and trade:getGil() == 0 then
        if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM) == QUEST_ACCEPTED then
            player:startEvent(349)
            player:tradeComplete()
            player:setCharVar("rootProblem", 2)
        end
    end
end

entity.onTrigger = function(player, npc)
    local rootProblem = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM)

    if rootProblem == QUEST_ACCEPTED and player:getCharVar("rootProblem") == 1 then
        player:startEvent(348, 0, 829)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
