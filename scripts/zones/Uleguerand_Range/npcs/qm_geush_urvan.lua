-----------------------------------
-- Area: Uleguerand_Range
--  NPC: ??? (Spawns Geush Urvan)
-----------------------------------
local ID = require("scripts/zones/Uleguerand_Range/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.items.HAUNTED_MULETA) and npcUtil.popFromQM(player, npc, ID.mob.GEUSH_URVAN) then
        player:confirmTrade()
        player:messageSpecial(ID.text.SPAWN_GEUSH, xi.items.HAUNTED_MULETA)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.FLUTTERING_CLOTH)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
