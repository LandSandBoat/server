-----------------------------------
-- Area: Fei'Yin
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Paralysis
-- !pos 4.239 -0.009 255.206 204
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_PARALYSIS)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_PARALYSIS)
end

return entity
