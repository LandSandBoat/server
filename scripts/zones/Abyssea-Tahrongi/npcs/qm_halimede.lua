-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_halimede (???)
-- Spawns Halimede
-- !pos -234 15 -603 45
-----------------------------------
local ID = require('scripts/zones/Abyssea-Tahrongi/IDs')
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.HALIMEDE, { xi.items.HIGH_QUALITY_CLIONID_WING })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.HIGH_QUALITY_CLIONID_WING })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
