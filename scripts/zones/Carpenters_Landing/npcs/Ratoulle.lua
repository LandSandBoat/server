-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Ratoulle
-- Type: Adventurer's Assistant
-- !pos -133.959 -3 60.839 2
-----------------------------------
require('scripts/globals/barge')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.barge.timekeeperOnTrigger(player, xi.barge.location.CENTRAL_LANDING, 19)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
