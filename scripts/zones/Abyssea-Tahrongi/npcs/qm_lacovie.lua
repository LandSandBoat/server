-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_lacovie (???)
-- Spawns Lacovie
-- !pos -325 23 432 45
-- !pos -336 24 442 45
-- !pos -316 24 442 45
-----------------------------------
local ID = require('scripts/zones/Abyssea-Tahrongi/IDs')
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.LACOVIE_1, { xi.ki.CHIPPED_SANDWORM_TOOTH, xi.ki.OVERGROWN_MANDRAGORA_FLOWER })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
