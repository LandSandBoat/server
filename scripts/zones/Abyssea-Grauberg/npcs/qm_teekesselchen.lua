-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_teekesselchen (???)
-- Spawns Teekesselchen
-- !pos 319 47 643 254
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_GRAUBERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.TEEKESSELCHEN, { xi.item.FLASK_OF_BUBBLING_OIL })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.FLASK_OF_BUBBLING_OIL })
end

return entity
