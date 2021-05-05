-----------------------------------
-- Area: Uleguerand_Range
--  NPC: ??? (Spawns Geush Urvan)
-----------------------------------
local ID = require("scripts/zones/Uleguerand_Range/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 1824) and npcUtil.popFromQM(player, npc, ID.mob.GEUSH_URVAN) then -- Haunted Muleta
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
