-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: qm19 (???)
-- Spawns Sobek
-- !pos 443 23 -369 216
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
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.SOBEK_1, { xi.ki.BLOODSTAINED_BUGARD_FANG, xi.ki.GNARLED_LIZARD_NAIL, xi.ki.MOLTED_PEISTE_SKIN })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
