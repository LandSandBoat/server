-----------------------------------
-- Area: Bibiki Bay
--  NPC: ???
-- Note: Used to spawn Shen
-- !pos -115.108 0.300 -724.664 4
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, xi.items.SHRIMP_LANTERN) and
        npcUtil.popFromQM(player, npc, ID.mob.SHEN)
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.SHEN_SPAWN)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SHEN_QM)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
