-----------------------------------
-- Area: Ordelles Caves
--  NPC: Treasure Chest
-- Involved In Quest: Signed In Blood and The Goblin Tailor
-- !zone 193
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
