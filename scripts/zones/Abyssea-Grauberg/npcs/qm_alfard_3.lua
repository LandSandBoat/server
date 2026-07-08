-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_alfard_3 (???)
-- Spawns Alfard
-- !pos 309 -39 189 254
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_GRAUBERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.ALFARD_OFFSET + 8, { xi.ki.VENOMOUS_HYDRA_FANG })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
