-----------------------------------
-- Area: Southern San dOria
--  NPC: Vaquelage
-- Type: Item Deliverer NPC
-- !pos 17.396 1.699 -29.357 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
