-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  NPC: ??? (Spawns Ullikummi)
-- !pos 739 -99 -581 178
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.items.CHUNK_OF_DIORITE) and
        npcUtil.popFromQM(player, npc, ID.mob.ULLIKUMMI)
    then
        -- Diorite
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
