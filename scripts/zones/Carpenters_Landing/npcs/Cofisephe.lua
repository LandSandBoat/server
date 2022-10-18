-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Cofisephe
-- Type: Phanauet Channel Barge Ticket Vendor
-- !pos 210.327 -3.885 -532.511 2
-----------------------------------
local ID = require("scripts/zones/Carpenters_Landing/IDs")
require("scripts/globals/barge")
-----------------------------------
local entity = {}
local eventid = 31

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.barge.ticketshopOnTrigger(player, eventid)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.barge.ticketshoponEventFinish(player, csid, option)
end

return entity
