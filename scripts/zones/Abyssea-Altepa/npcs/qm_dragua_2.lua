-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_dragua_2 (???)
-- Spawns Dragua
-- !pos -221 0.8 -350 218
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ALTEPA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.DRAGUA_OFFSET + 4, { xi.ki.BLOODIED_DRAGON_EAR })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
