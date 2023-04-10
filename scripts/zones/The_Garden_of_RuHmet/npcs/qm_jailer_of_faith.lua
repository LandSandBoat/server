-----------------------------------
-- Area: The_Garden_of_RuHmet
--  NPC: qm_jailer_of_faith (???)
-- Note: Spawn Jailer of Faith by trading High-Quality Euvhi Organ
-- North / Hume tower  !pos -420 0 -157 35
-- NE / Elvaan tower   !pos -157 0 -340 35
-- SE / Galka tower    !pos -260 0 -643 35
-- SW / Tarutaru tower !pos -580 0 -644 35
-- NW / Mithra tower   !pos -683 0 -340 35
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 1899) and
        npcUtil.popFromQM(player, npc, ID.mob.JAILER_OF_FAITH, { radius = 1 })
    then
        -- High-Quality Euvhi Organ
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
