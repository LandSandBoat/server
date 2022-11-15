-----------------------------------
-- Area: Upper Delkfutt's Tower
--  NPC: ??? (Spawns Alkyoneus)
-- !pos -300 -175 22 158
-----------------------------------
local ID = require("scripts/zones/Upper_Delkfutts_Tower/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 2385) and
        npcUtil.popFromQM(player, npc, ID.mob.ALKYONEUS)
    then
        -- Moldy Buckler
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
