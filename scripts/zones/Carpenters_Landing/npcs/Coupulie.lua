-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Coupulie
-- !pos -313.585 -3.628 490.944 2
-----------------------------------
require('scripts/globals/barge')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.barge.onTicketShopTrigger(player, 32)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.barge.onTicketShopEventFinish(player, csid, option, npc)
end

return entity
