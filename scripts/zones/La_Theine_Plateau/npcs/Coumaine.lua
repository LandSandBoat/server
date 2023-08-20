-----------------------------------
-- Area: La Theine Plateau
--  NPC: Coumaine
-- Type: Chocobo Vendor
-- !pos 441.782 24.231 20.254 102
-----------------------------------
local entity = {}

local eventSucceed = 120
local eventFail    = 121

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.chocobo.renterOnTrigger(player, eventSucceed, eventFail)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocobo.renterOnEventFinish(player, csid, option, eventSucceed)
end

return entity
