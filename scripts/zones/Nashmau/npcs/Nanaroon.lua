-----------------------------------
-- Area: Nashmau
--  NPC: Nanaroon
-- Type: Item Deliverer
-- !pos -2.404    -6    37.141 53
-----------------------------------
local ID = zones[xi.zone.NASHMAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.NANA_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
