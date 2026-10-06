-----------------------------------
-- Area: La Theine Plateau
--  NPC: Coumaine
-- Type: Chocobo Vendor
-- !pos 441.782 24.231 20.254 102
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 120
local eventFail    = 121

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
