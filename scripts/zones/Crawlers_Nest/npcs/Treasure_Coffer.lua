-----------------------------------
-- Area: Crawler Nest
--  NPC: Treasure Coffer
-- !zone 197
-----------------------------------
require("scripts/globals/treasure")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.treasure.onTrade(player, npc, trade, tpz.treasure.type.COFFER)
end

function onTrigger(player, npc)
    tpz.treasure.onTrigger(player, tpz.treasure.type.COFFER)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
