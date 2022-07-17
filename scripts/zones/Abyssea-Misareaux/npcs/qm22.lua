-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: qm22 (???)
-- Spawns Amhuluk
-- !pos 0 -15 -34 216
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
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.AMHULUK_2, { xi.ki.JAGGED_APKALLU_BEAK, xi.ki.CLIPPED_BIRD_WING, xi.ki.BLOODIED_BAT_FUR })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
