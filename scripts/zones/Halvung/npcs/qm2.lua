-----------------------------------
-- Area: Halvung
--  NPC: ??? (Spawn Dextrose(ZNM T2))
-- !pos -144 11 464 62
-----------------------------------
local ID = require("scripts/zones/Halvung/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 2589) and npcUtil.popFromQM(player, npc, ID.mob.DEXTROSE) then -- Granulated Sugar
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_HAPPENS)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
