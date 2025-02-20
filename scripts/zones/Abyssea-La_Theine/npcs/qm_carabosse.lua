-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_carabosse (???)
-- Spawns Carabosse
-- !pos 11 17 148 132
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_LA_THEINE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.CARABOSSE_OFFSET, { xi.ki.PELLUCID_FLY_EYE, xi.ki.SHIMMERING_PIXIE_PINION })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
