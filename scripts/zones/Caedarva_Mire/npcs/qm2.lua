-----------------------------------
-- Area: Caedarva Mire
--  NPC: ??? (Spawn Experimental Lamia(ZNM T3))
-- !pos -773 -11 322 79
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 2595) and
        npcUtil.popFromQM(player, npc, ID.mob.EXPERIMENTAL_LAMIA)
    then
        -- Trade Myrrh
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SHED_LEAVES)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
