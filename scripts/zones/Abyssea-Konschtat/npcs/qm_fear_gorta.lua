-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_fear_gorta (???)
-- Spawns Fear Gorta
-- !pos 630.000 33.608 410.000 15
-----------------------------------
local ID = require('scripts/zones/Abyssea-Konschtat/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.FEAR_GORTA, { xi.items.SQUARE_OF_MOONGLOW_CLOTH })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.SQUARE_OF_MOONGLOW_CLOTH })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
