-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_gaizkin (???)
-- Spawns Gaizkin
-- !pos -132.253 0.015 0.753 215
-----------------------------------
local ID = require('scripts/zones/Abyssea-Attohwa/IDs')
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.GAIZKIN, { xi.items.HANDFUL_OF_BONE_CHIPS })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.HANDFUL_OF_BONE_CHIPS })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
