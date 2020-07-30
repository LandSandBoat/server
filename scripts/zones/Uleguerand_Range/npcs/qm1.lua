-----------------------------------
--  Area: Uleguerand_Range
--   NPC: ??? (Spawns Geush Urvan)
-----------------------------------
local ID = require("scripts/zones/Uleguerand_Range/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 1824) and npcUtil.popFromQM(player, npc, ID.mob.GEUSH_URVAN) then -- Haunted Muleta
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
