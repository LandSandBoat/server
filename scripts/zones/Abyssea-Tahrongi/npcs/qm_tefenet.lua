-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_tefenet (???)
-- Spawns Tefenet
-- !pos -127 15 239 45
-----------------------------------
local ID = require('scripts/zones/Abyssea-Tahrongi/IDs')
require("scripts/globals/abyssea")
require("scripts/globals/items")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.TEFENET, { xi.items.SHOCKING_WHISKER })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.SHOCKING_WHISKER })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
