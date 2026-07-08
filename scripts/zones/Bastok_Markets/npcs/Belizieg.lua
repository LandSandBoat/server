-----------------------------------
-- Area: Bastok Markets
--  NPC: Belizieg
-- Type: Item Deliverer
-- !pos -323.673 -16.001 -49.930 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
