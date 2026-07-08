-----------------------------------
-- Area: Mhaura
--  NPC: Panoru-Kanoru
-- Type: Item Deliverer
-- !pos 5.241    -4.035    93.891 249
-----------------------------------
local ID = zones[xi.zone.MHAURA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.PANORU_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
