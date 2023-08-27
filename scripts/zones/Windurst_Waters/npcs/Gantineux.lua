-----------------------------------
-- Area: Windurst Waters
--  NPC: Gantineux
-- Starts Quest: Acting in Good Faith
-- !pos -83 -9 3 238
-----------------------------------
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ACTING_IN_GOOD_FAITH) == QUEST_COMPLETED then
        player:startEvent(10023) -- New standard dialog after "Acting in Good Faith"
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
