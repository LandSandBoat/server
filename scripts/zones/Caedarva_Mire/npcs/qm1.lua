-----------------------------------
-- Area: Caedarva Mire
--  NPC: ??? (Spawn Verdelet(ZNM T2))
-- !pos 417 -19 -69 79
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 2599) and npcUtil.popFromQM(player, npc, ID.mob.VERDELET) then -- Mint Drop
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
