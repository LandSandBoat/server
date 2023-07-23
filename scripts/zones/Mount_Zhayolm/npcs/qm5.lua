-----------------------------------
-- Area: Mount Zhayolm
--  NPC: ??? (Spawn Sarameya(ZNM T4))
-- !pos 322 -14 -581 61
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.items.CHUNK_OF_BUFFALO_CORPSE) and
        npcUtil.popFromQM(player, npc, ID.mob.SARAMEYA, { hide = 0 })
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.PUTRID_ODOR)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
