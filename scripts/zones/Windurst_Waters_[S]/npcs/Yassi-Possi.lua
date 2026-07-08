-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Yassi-Possi
-- Type: Item Deliverer
-- !pos 153.992 -0.001 -18.687 94
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.YASSI_POSSI_DIALOG)
    player:openSendBox()
end

return entity
