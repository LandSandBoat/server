-----------------------------------
-- Area: The_Garden_of_RuHmet
--  NPC: ??? (Jailer of Faith Spawn)
-- Allows players to spawn the Jailer of Faith by trading 1 High-Quality Euvhi Organ to a ???.
-- !zone 35
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 1899) and npcUtil.popFromQM(player, npc, ID.mob.JAILER_OF_FAITH, {radius = 1}) then -- High-Quality Euvhi Organ
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
