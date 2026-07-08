-----------------------------------
-- Area: Port San d'Oria
--  NPC: Comittie
-- !pos -6.570 -9.8 -147.952 232
-----------------------------------
local ID = zones[xi.zone.PORT_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
