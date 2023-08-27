-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_berstuk (???)
-- Spawns Berstuk
-- !pos -280.000 -4.000 -38.516 215
-----------------------------------
local ID = require('scripts/zones/Abyssea-Attohwa/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.BERSTUK, { xi.items.EXTENDED_EYESTALK })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.EXTENDED_EYESTALK })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
