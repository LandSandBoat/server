-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Echanie
-- !pos -148.5785 -2.9479 45.7221 2
-----------------------------------
require('scripts/globals/barge')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.barge.onTicketShopTrigger(player, 43)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.barge.onTicketShopEventFinish(player, csid, option, npc)
end

return entity
