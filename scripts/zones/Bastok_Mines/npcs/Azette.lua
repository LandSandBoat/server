-----------------------------------
-- Area: Bastok Mines
--  NPC: Azette
-- Type: Chocobo Renter
-- !pos 43.882 0.750 -108.629 234
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 61
local eventFail    = 64

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
