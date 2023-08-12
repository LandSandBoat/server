-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_poroggo_dom_juan (???)
-- Spawns Poroggo Dom Juan
-- !pos 405.785 26.404 -543.056 132
-----------------------------------
local ID = require('scripts/zones/Abyssea-La_Theine/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.POROGGO_DOM_JUAN, { xi.items.BUG_EATEN_HAT })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.BUG_EATEN_HAT })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
