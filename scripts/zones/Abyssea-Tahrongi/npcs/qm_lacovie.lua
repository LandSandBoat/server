-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_lacovie (???)
-- Spawns Lacovie
-- !pos -325 23 432 45
-- !pos -336 24 442 45
-- !pos -316 24 442 45
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_TAHRONGI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.LACOVIE_OFFSET, { xi.ki.CHIPPED_SANDWORM_TOOTH, xi.ki.OVERGROWN_MANDRAGORA_FLOWER })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
