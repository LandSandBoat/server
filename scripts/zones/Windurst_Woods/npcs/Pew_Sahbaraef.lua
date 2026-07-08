-----------------------------------
-- Area: Windurst Woods
--  NPC: Pew Sahbaraef
-- Type: Item Deliverer
-- !pos 61.899 -2.5 -112.956 241
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
