-----------------------------------
-- Area: Bastok Mines
--  NPC: Gawful
-- Type: Item Deliverer
-- !pos -22.416 -3.999 -56.076 234
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
