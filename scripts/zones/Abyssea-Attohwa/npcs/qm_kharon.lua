-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_kharon (???)
-- Spawns Kharon
-- !pos -403.909 -4.234 200.832 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.KHARON, { xi.item.HANDFUL_OF_BONE_CHIPS })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.HANDFUL_OF_BONE_CHIPS })
end

return entity
