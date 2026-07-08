-----------------------------------
-- Area: Yahse Hunting Grounds
-- NPC: Geomantic Reservoir
-- Unlocks: Geo-Wilt
-- !pos 412.263 4.161 111.199 260
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.geomanticReservoir.onTrigger(player, npc, xi.magic.spell.GEO_WILT)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.geomanticReservoir.onEventFinish(player, csid, xi.magic.spell.GEO_WILT)
end

return entity
