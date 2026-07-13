-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Bertenont
-- !pos -165 0.1 226 231
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.BERTENONT_DIALOG)
end

return entity
