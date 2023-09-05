-----------------------------------
-- Area: Arrapago Reef
--  NPC: ??? (Spawn Zareehkl the Jubilant(ZNM T2))
-- !pos 176 -4 182 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, xi.items.MERROW_NO_11_MOLTING) and
        npcUtil.popFromQM(player, npc, ID.mob.ZAREEHKL_THE_JUBILANT, { message = ID.text.DRAWS_NEAR })
    then
        player:confirmTrade()
    end
end

return entity
