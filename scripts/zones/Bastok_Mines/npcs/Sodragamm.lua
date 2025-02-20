-----------------------------------
-- Area: Bastok Mines
--  NPC: Sodragamm
-- Type: Item Deliverer
-- !pos -24.741 -1 -64.944 234
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
