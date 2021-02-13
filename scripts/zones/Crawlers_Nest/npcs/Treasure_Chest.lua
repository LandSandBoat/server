-----------------------------------
-- Area: Crawler Nest
--  NPC: Treasure Chest
-- Involved In Quest: Enveloped in Darkness
-- !zone 197
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
