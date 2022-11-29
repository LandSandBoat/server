-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Echanie
-- Type: Standard NPC
-- !pos -148.3136 -2.9521 46.4020 128
-----------------------------------
require("scripts/globals/barge")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.barge.ticketshopOnTrigger(player, 43)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.barge.ticketshopOnEventFinish(player, csid, option)
end

return entity
