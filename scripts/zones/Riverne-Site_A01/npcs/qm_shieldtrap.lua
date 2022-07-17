-----------------------------------
-- Area: Riverne Site #A01
--  NPC: ??? - Shieldtrap spawn
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_A01/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.items.SHIELD_BUG) and npcUtil.popFromQM(player, npc, ID.mob.SHIELDTRAP) then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

return entity
