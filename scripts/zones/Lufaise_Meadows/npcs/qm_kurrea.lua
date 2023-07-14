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
    if
        npcUtil.tradeHas(trade, xi.items.BOWL_OF_ADAMANTOISE_SOUP) and
        npcUtil.popFromQM(player, npc, ID.mob.KURREA)
    then
        player:messageSpecial(ID.text.KURREA_TEXT + 1, xi.items.BOWL_OF_ADAMANTOISE_SOUP)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.KURREA_TEXT)
end

return entity
