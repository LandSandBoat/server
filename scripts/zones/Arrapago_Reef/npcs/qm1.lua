-----------------------------------
-- Area: Arrapago Reef
--  NPC: ??? (Spawn Lil'Apkallu(ZNM T1))
-- !pos 488 -1 166 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, xi.items.GREENLING) and
        npcUtil.popFromQM(player, npc, ID.mob.LIL_APKALLU, { message = ID.text.DRAWS_NEAR })
    then
        player:confirmTrade()
    end
end

return entity
