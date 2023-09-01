-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos 448.045 -7.808 319.980 116
-----------------------------------
local ID = zones[xi.zone.EAST_SARUTABARUTA]
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
        player:setCharVar('anExplorer-CurrentTablet', 0x00800)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
