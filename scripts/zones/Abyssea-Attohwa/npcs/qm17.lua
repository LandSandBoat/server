-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm17 (???)
-- Spawns Itzpapalotl
-- !pos 439.939 19.820 -194.226 215
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/keyitems')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- xi.abyssea.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.ITZPAPALOTL, { xi.ki.VENOMOUS_WAMOURA_FEELER, xi.ki.BULBOUS_CRAWLER_COCOON, xi.ki.DISTENDED_CHIGOE_ABDOMEN })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
