-----------------------------------
-- Area: Gusgen Mines
--  NPC: Treasure Chest
-- Involved In Quest: The Goblin Tailor
-- !zone 196
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
