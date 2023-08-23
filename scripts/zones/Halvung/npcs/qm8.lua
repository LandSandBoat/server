-----------------------------------
-- Area: Halvung
--  NPC: ??? (Bracelet of verve)
-- Trade Moblin Oil
-----------------------------------
local ID = require("scripts/zones/Halvung/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/items")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.items.MOBLIN_OIL) and
        not player:hasKeyItem(xi.ki.BRACELET_OF_VERVE)
    then
        player:confirmTrade()
        npcUtil.giveKeyItem(player, xi.ki.BRACELET_OF_VERVE)
    else
        player:messageSpecial(ID.text.DULL_PIECE)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.DULL_PIECE)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
