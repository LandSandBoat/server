-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_kukulkan (???)
-- Spawns Kukulkan
-- !pos -40.000 71.992 560.000 15
-- !pos -40.000 68.692 575.000 15
-- !pos -25.000 68.792 560.000 15
-----------------------------------
local ID = require('scripts/zones/Abyssea-Konschtat/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.KUKULKAN_1, { xi.ki.TATTERED_HIPPOGRYPH_WING, xi.ki.CRACKED_WIVRE_HORN, xi.ki.MUCID_AHRIMAN_EYEBALL })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
