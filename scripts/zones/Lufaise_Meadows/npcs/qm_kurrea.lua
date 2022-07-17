-----------------------------------
-- Area: Lufaise Meadows
--  NPC: ??? - Kurrea spawn
-- !pos -249.320 -16.189 41.497 24
-----------------------------------
local ID = require("scripts/zones/Lufaise_Meadows/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.items.ADAMANTOISE_SOUP) and npcUtil.popFromQM(player, npc, ID.mob.KURREA) then
        player:confirmTrade()
        player:messageSpecial(ID.text.KURREA_SPAWN, xi.items.ADAMANTOISE_SOUP)
    else
        player:messageSpecial(ID.text.KURREA_WRONG_TRADE)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.KURREA_TRIGGER)
end

return entity
