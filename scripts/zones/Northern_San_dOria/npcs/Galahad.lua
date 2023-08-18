-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Galahad
-- Type: Consulate Representative NPC
-- !pos -51.984 -2.000 -15.373 231
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.GALAHAD_DIALOG)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
