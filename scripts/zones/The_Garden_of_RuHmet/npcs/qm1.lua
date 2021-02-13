-----------------------------------
-- Area: The_Garden_of_RuHmet
--  NPC: ??? (Jailer of Fortitude Spawn)
-- Allows players to spawn the Jailer of Fortitude by trading 12 Ghrah M Chips to a ???.
-- !zone 35
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, {{1872, 12}}) and -- 12x Ghrah M Chips
        npcUtil.popFromQM(player, npc, {ID.mob.JAILER_OF_FORTITUDE, ID.mob.KFGHRAH_WHM, ID.mob.KFGHRAH_BLM}, {radius = 1})
    then
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
