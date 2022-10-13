-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Echanie
-- Type: Standard NPC
-- !pos -148.3136 -2.9521 46.4020 128
-----------------------------------
require("scripts/globals/barge")
-----------------------------------
local entity = {}
local eventId = 43

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.barge.ticketshopOnTrigger(player, eventId)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, eventId, csid, option)
    xi.barge.ticketshopOnEventFinish(player, eventId, csid, option)
end

return entity