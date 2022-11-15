-----------------------------------
-- Area: Upper Delkfutt's Tower
--  NPC: ??? (Spawns Pallas)
-- !pos -302.000 -159.000 21.000 158
-----------------------------------
local ID = require("scripts/zones/Upper_Delkfutts_Tower/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 2386) and
        npcUtil.popFromQM(player, npc, ID.mob.PALLAS)
    then
        -- Hoary Battle Horn
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
