-----------------------------------
-- Area: Windurst Walls
--  NPC: Kenono
-- Type: Item Deliverer
-- !pos 59.727 -2.500 -63.036
-----------------------------------
local ID = zones[xi.zone.WINDURST_WALLS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
