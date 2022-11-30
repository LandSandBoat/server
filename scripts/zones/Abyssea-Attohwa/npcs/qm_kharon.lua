-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_kharon (???)
-- Spawns Kharon
-- !pos -403.909 -4.234 200.832 215
-----------------------------------
local ID = require('scripts/zones/Abyssea-Attohwa/IDs')
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.KHARON, { xi.items.HANDFUL_OF_BONE_CHIPS })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.HANDFUL_OF_BONE_CHIPS })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
