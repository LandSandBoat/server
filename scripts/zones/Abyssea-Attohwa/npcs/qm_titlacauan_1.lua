-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_titlacauan_1 (???)
-- Spawns Titlacauan
-- !pos -404.436 -4.000 246.000 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.TITLACAUAN_OFFSET, { xi.keyItem.BLOTCHED_DOOMED_TONGUE, xi.keyItem.CRACKED_SKELETON_CLAVICLE, xi.keyItem.WRITHING_GHOST_FINGER, xi.keyItem.RUSTED_HOUND_COLLAR })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
