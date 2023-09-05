-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_pallid_percy (???)
-- Spawns Pallid Percy
-- !pos 281.063 20.376 174.011 215
-----------------------------------
local ID = require('scripts/zones/Abyssea-Attohwa/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.PALLID_PERCY, { xi.items.VIAL_OF_UNDYING_OOZE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.VIAL_OF_UNDYING_OOZE })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
