-----------------------------------
-- Area: Bastok Markets
--  NPC: Khonzon
-- Type: Item Deliverer
-- !pos -323.744 -16.001 -88.698 235
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
