-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_poroggo_dom_juan (???)
-- Spawns Poroggo Dom Juan
-- !pos 405.785 26.404 -543.056 132
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_LA_THEINE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.POROGGO_DOM_JUAN, { xi.item.BUG_EATEN_HAT })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.BUG_EATEN_HAT })
end

return entity
