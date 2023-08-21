-----------------------------------
-- Area: Yhoator Jungle
--  NPC: Paurelde
-- Type: Chocobo Renter
-- !pos -273.301 0.300 -149.800 124
-----------------------------------
local entity = {}

local eventSucceed = 12
local eventFail    = 13

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
