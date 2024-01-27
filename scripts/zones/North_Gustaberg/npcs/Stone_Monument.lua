-----------------------------------
-- Area: North Gustaberg
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos -199.635 96.106 505.624 106
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.LUMP_OF_SELBINA_CLAY) and
        npcUtil.giveItem(player, xi.item.CLAY_TABLET)
    then
        player:confirmTrade()
        player:setCharVar('anExplorer-CurrentTablet', 0x00020)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
