-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_amphitrite_1 (???)
-- Spawns Amphitrite
-- !pos -147 -31 -220 254
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_GRAUBERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.AMPHITRITE_OFFSET, { xi.ki.VARIEGATED_URAGNITE_SHELL })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
