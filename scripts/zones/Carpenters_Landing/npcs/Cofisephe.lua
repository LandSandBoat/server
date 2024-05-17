-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Cofisephe
-- Type: Adventurer's Assistant
-- !pos 210.327 -3.885 -532.511 2
-----------------------------------
require('scripts/globals/barge')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.barge.onTicketShopTrigger(player, 31)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    return xi.barge.onTicketShopEventFinish(player, csid, option, npc)
end

return entity
