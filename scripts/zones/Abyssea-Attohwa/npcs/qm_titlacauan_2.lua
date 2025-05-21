-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_titlacauan_2 (???)
-- Spawns Titlacauan
-- !pos -389.437 -4.000 246.001 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.TITLACAUAN_OFFSET + 4, { xi.ki.BLOTCHED_DOOMED_TONGUE, xi.ki.CRACKED_SKELETON_CLAVICLE, xi.ki.WRITHING_GHOST_FINGER, xi.ki.RUSTED_HOUND_COLLAR })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
