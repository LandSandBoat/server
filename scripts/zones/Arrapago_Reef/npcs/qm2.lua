-----------------------------------
-- Area: Arrapago Reef
--  NPC: ??? (Spawn Velionis(ZNM T1))
-- !pos 311 -3 27 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, xi.items.GOLDEN_TEETH) and
        npcUtil.popFromQM(player, npc, ID.mob.VELIONIS, { message = ID.text.DRAWS_NEAR })
    then
        player:confirmTrade()
    end
end

return entity
