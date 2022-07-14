-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm13 (???)
-- Spawns Chloris
-- !pos 160 0 -15 45
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
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.CHLORIS, { xi.ki.VEINOUS_HECTEYES_EYELID, xi.ki.TORN_BAT_WING, xi.ki.GORY_SCORPION_CLAW, xi.ki.MOSSY_ADAMANTOISE_SHELL })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
