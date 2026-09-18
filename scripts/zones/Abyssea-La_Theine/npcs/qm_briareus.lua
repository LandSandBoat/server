-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_briareus (???)
-- Spawns Briareus
-- !pos -179 7 259 132
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_LA_THEINE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.BRIAREUS_OFFSET, { xi.keyItem.DENTED_GIGAS_SHIELD, xi.keyItem.WARPED_GIGAS_ARMBAND, xi.keyItem.SEVERED_GIGAS_COLLAR })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
