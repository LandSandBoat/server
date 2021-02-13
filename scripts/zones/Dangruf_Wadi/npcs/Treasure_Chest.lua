-----------------------------------
-- Area: Dangruf Wadi
--  NPC: Treasure Chest
-- !zone 191
-----------------------------------
require("scripts/globals/treasure")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.treasure.onTrade(player, npc, trade, tpz.treasure.type.CHEST)
end

entity.onTrigger = function(player, npc)
    tpz.treasure.onTrigger(player, tpz.treasure.type.CHEST)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
