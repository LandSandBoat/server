-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_clingy_clare (???)
-- Spawns Clingy Clare
-- !pos 150.000 17.601 90.000 15
-----------------------------------
local ID = require('scripts/zones/Abyssea-Konschtat/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.CLINGY_CLARE, { xi.items.TINY_MORBOL_VINE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.TINY_MORBOL_VINE })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
