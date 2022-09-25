-----------------------------------
-- Area: Arrapago Reef
--  NPC: ??? (Spawn Zareehkl the Jubilant(ZNM T2))
-- !pos 176 -4 182 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.items.MERROW_NO_11_MOLTING) and
        npcUtil.popFromQM(player, npc, ID.mob.ZAREEHKL_THE_JUBILANT, { message = ID.text.DRAWS_NEAR })
    then -- Trade Merrow No. 11 Molting
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.FLUTTERY_OBJECTS)
end

return entity
