-----------------------------------
-- Area: Arrapago Reef
--  NPC: ??? (Spawn Nuhn(ZNM T3))
-- !pos -451 -7 389 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 2596) and npcUtil.popFromQM(player, npc, ID.mob.NUHN) then -- Trade Rose Scampi
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.STIFLING_STENCH)
end

return entity
