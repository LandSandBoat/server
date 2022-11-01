-----------------------------------
-- Area: Port San d'Oria
--  NPC: Prietta
-----------------------------------
require("scripts/quests/flyers_for_regine")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 1) -- FLYERS FOR REGINE
end

entity.onTrigger = function(player, npc)
    player:startEvent(596)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
