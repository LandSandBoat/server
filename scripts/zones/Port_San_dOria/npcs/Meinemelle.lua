-----------------------------------
-- Area: Port San d'Oria
--  NPC: Meinemelle
-- !pos -8.289 -9.3 -146.093 232
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
