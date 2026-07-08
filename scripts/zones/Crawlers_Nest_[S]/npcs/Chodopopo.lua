-----------------------------------
-- Area: Crawlers' Nest [S]
--  NPC: Chodopopo
-- Type: Item Deliverer
-- !pos 100.528 -32.272 -58.739 171
-----------------------------------
local ID = zones[xi.zone.CRAWLERS_NEST_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
