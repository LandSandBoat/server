-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_drekavac (???)
-- Spawns Drekavac
-- !pos -158.000 -0.340 220.000 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.DREKAVAC, { xi.item.SET_OF_WAILING_RAGS })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.SET_OF_WAILING_RAGS })
end

return entity
