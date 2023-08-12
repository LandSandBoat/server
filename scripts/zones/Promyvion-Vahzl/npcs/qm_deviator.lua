-----------------------------------
-- Area: Promyvion-Vahzl
--  NPC: ???
-- Notes: Spawn Deviator Floor 3
-- !pos 302.756 -2.244 -179.892 22
-----------------------------------
local ID = require("scripts/zones/Promyvion-Vahzl/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.items.REMNANT_OF_A_CEREBRATOR) and
        npcUtil.popFromQM(player, npc, ID.mob.DEVIATOR)
    then
        player:messageSpecial(ID.text.ON_NM_SPAWN)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.POPPED_NM_OFFSET)
end

return entity
