-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_dozing_dorian (???)
-- Spawns Dozing Dorian
-- !pos 703 40 283 132
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_LA_THEINE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.DOZING_DORIAN, { xi.item.DRIED_CHIGOE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.DRIED_CHIGOE })
end

return entity
