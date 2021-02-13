-----------------------------------
-- Area: Aydeewa Subterrane
--  NPC: ??? (Spawn Pandemonium Warden)
-- !pos 200 33 -140 68
-----------------------------------
local ID = require("scripts/zones/Aydeewa_Subterrane/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 2572) and npcUtil.popFromQM(player, npc, ID.mob.PANDEMONIUM_WARDEN) then -- Pandemonium Key
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_HAPPENS)
end

return entity
