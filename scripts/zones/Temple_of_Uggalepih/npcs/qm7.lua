-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (Spawns Death From Above NM)
-- Involved In Mission: Death From Above
-- !pos 53 1 -32 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.items.BAG_OF_BEE_LARVAE) and
        npcUtil.popFromQM(player, npc, ID.mob.DEATH_FROM_ABOVE)
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NM_OFFSET + 4)
end

return entity
