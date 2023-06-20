-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_ulhuadshi_2 (???)
-- Spawns Ulhuadshi
-- !pos 361.193 20.005 199.340 215
-----------------------------------
local ID = require('scripts/zones/Abyssea-Attohwa/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.ULHUADSHI_2, { xi.ki.MUCID_WORM_SEGMENT, xi.ki.SHRIVELED_HECTEYES_STALK })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
