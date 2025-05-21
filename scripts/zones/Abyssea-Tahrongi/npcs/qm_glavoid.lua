-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_glavoid (???)
-- Spawns Glavoid
-- !pos 196 32 400 45
-- !pos 196 34 415 45
-- !pos 211 33 400 45
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_TAHRONGI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.GLAVOID_OFFSET, { xi.ki.LUXURIANT_MANTICORE_MANE, xi.ki.FAT_LINED_COCKATRICE_SKIN, xi.ki.STICKY_GNAT_WING, xi.ki.SODDEN_SANDWORM_HUSK })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
