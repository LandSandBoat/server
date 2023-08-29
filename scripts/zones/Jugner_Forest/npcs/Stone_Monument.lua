-----------------------------------
-- Area: Jugner Forest
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos -65.976 -23.829 -661.362 104
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

entity.onTrade = function(player, npc, trade)
    if
        trade:getItemCount() == 1 and
        trade:hasItemQty(xi.item.LUMP_OF_SELBINA_CLAY, 1)
    then
        player:tradeComplete()
        player:addItem(xi.item.CLAY_TABLET)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.CLAY_TABLET)
        player:setCharVar('anExplorer-CurrentTablet', 0x00010)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
