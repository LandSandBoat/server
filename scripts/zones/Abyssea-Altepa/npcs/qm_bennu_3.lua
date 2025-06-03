-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_bennu_3 (???)
-- Spawns Bennu
-- !pos -221 0.950 -320 218
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ALTEPA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.BENNU_OFFSET + 8, { xi.ki.RESPLENDENT_ROC_QUILL })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
