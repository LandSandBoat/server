-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Coupulie
-- Type: Standard NPC
-- !pos -313.585 -3.628 490.944 2
-----------------------------------
require("scripts/globals/barge")
-----------------------------------
local entity = {}
local eventId = 32

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.barge.ticketshopOnTrigger(player, eventId)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.barge.ticketshoponEventFinish(player, csid, option)
end

return entity
