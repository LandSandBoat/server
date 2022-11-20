-----------------------------------
-- Area: Meriphataud Mountains
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos 450.741 2.110 -290.736 119
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.items.LUMP_OF_SELBINA_CLAY) and
        npcUtil.giveItem(player, xi.items.CLAY_TABLET)
    then
        player:setCharVar("anExplorer-CurrentTablet", 0x04000)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
