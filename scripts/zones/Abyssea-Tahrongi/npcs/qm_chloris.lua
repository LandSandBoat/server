-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_chloris (???)
-- Spawns Chloris
-- !pos 160 0 -15 45
-- !pos 160 0 0 45
-- !pos 160 0 -30 45
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_TAHRONGI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.CHLORIS_OFFSET, { xi.ki.TORN_BAT_WING, xi.ki.VEINOUS_HECTEYES_EYELID, xi.ki.MOSSY_ADAMANTOISE_SHELL, xi.ki.GORY_SCORPION_CLAW })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
