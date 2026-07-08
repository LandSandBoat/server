-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_kampe (???)
-- Spawns Kampe
-- !pos -401.612 3.738 -200.972 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.KAMPE, { xi.item.GORY_PINCER })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.GORY_PINCER })
end

return entity
