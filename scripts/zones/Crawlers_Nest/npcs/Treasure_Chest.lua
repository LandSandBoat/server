-----------------------------------
-- Area: Crawler Nest
--  NPC: Treasure Chest
-- Involved In Quest: Enveloped in Darkness
-- !zone 197
-----------------------------------
require("scripts/globals/treasure")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.treasure.onTrade(player, npc, trade, tpz.treasure.type.CHEST)
end

function onTrigger(player, npc)
    tpz.treasure.onTrigger(player, tpz.treasure.type.CHEST)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
