-----------------------------------
-- Area: Rolanberry Fields
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos 362.479 -34.894 -398.994 110
-----------------------------------
local ID = require("scripts/zones/Rolanberry_Fields/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.items.LUMP_OF_SELBINA_CLAY) and
        npcUtil.giveItem(player, xi.items.CLAY_TABLET)
    then
        player:confirmTrade()
        player:setCharVar("anExplorer-CurrentTablet", 0x00200)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
