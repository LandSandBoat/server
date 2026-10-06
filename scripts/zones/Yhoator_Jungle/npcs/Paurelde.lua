-----------------------------------
-- Area: Yhoator Jungle
--  NPC: Paurelde
-- Type: Chocobo Renter
-- !pos -273.301 0.300 -149.800 124
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 12
local eventFail    = 13

entity.onTrade = function(player, npc, trade)
    xi.rentalChocobo.renterOnTrade(player, npc, trade, eventSucceed, eventFail)
end

entity.onTrigger = function(player, npc)
    xi.rentalChocobo.renterOnTrigger(player, npc, eventSucceed, eventFail)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.rentalChocobo.renterOnEventFinish(player, csid, option, eventSucceed)
end

return entity
