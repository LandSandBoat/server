-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_trudging_thomas (???)
-- Spawns Trudging Thomas
-- !pos 278 24 -82 132
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_LA_THEINE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.TRUDGING_THOMAS, { xi.item.RAW_MUTTON_CHOP })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.RAW_MUTTON_CHOP })
end

return entity
