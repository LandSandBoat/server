-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_drekavac (???)
-- Spawns Drekavac
-- !pos -158.000 -0.340 220.000 215
-----------------------------------
local ID = require('scripts/zones/Abyssea-Attohwa/IDs')
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.DREKAVAC, { xi.items.SET_OF_WAILING_RAGS })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.SET_OF_WAILING_RAGS })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
