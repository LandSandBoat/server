-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Nembet
-- !pos 147 -3 110 80
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
