-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_hadhayosh (???)
-- Spawns Hadhayosh
-- !pos 434 24 41 132
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_LA_THEINE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.HADHAYOSH_OFFSET, { xi.keyItem.MARBLED_MUTTON_CHOP, xi.keyItem.BLOODIED_SABER_TOOTH, xi.keyItem.GLITTERING_PIXIE_CHOKER, xi.keyItem.BLOOD_SMEARED_GIGAS_HELM })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
