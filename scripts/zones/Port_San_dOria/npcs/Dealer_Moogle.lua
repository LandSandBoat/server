-----------------------------------
-- Area: Port San d'Oria
--  NPC: Dealer Moogle
-- !pos 13.026 -4.000 -87.403 232
-----------------------------------
require("scripts/globals/dealer_moogle")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dealerMoogle.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dealerMoogle.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.dealerMoogle.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.dealerMoogle.onEventFinish(player, csid, option)
end

return entity
