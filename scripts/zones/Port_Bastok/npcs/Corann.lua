-----------------------------------
-- Area: Port Bastok
--  NPC: Corann
-- Start & Finishes Quest: The Quadav's Curse
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local outOfOneShell = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.OUT_OF_ONE_S_SHELL)

    if outOfOneShell == QUEST_COMPLETED then
        player:startEvent(88)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
