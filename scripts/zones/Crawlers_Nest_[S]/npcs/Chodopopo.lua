-----------------------------------
-- Area: Crawlers' Nest [S]
--  NPC: Chodopopo
-- Type: Item Deliverer
-- !pos 100.528 -32.272 -58.739 171
-----------------------------------
local ID = zones[xi.zone.CRAWLERS_NEST_S]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
