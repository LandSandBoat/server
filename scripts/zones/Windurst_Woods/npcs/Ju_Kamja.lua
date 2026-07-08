-----------------------------------
-- Area: Windurst Woods
--  NPC: Ju Kamja
-- Type: Item Deliverer
-- !pos 58.145 -2.5 -136.91 241
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
