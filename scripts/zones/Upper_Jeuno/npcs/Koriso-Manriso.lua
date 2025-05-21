-----------------------------------
-- Area: Upper Jeuno
--  NPC: Koriso-Manriso
-- Type: Item Deliverer
-- !pos -64.39 1 23.704 244
-----------------------------------
local ID = zones[xi.zone.UPPER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
