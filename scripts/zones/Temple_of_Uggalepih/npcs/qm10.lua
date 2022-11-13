-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (Spawns Sozu Rogberry NM)
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 2387) and
        npcUtil.popFromQM(player, npc, ID.mob.SOZU_ROGBERRY)
    then
        -- Flickering Lantern
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

return entity
