-----------------------------------
-- Area: Den of Rancor
--  NPC: ??? - HakuTaku spawn
-- !pos 24 25 -306 160
-----------------------------------
local ID = require("scripts/zones/Den_of_Rancor/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 1298) and
        npcUtil.popFromQM(player, npc, ID.mob.HAKUTAKU)
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
end

return entity
