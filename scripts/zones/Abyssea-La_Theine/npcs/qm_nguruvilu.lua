-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_nguruvilu (???)
-- Spawns Nguruvilu
-- !pos 311 23 -524 132
-----------------------------------
local ID = require('scripts/zones/Abyssea-La_Theine/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.NGURUVILU, { xi.items.WINTER_PUK_EGG })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.WINTER_PUK_EGG })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
