-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_kampe (???)
-- Spawns Kampe
-- !pos -401.612 3.738 -200.972 215
-----------------------------------
local ID = require('scripts/zones/Abyssea-Attohwa/IDs')
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.KAMPE, { xi.items.GORY_PINCER })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.GORY_PINCER })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
