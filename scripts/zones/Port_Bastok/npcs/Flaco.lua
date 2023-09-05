-----------------------------------
-- Area: Port Bastok
--  NPC: Flaco
-- Fame Checker
-- !zone 236
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(210 + player:getFameLevel(xi.quest.fame_area.BASTOK))
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
