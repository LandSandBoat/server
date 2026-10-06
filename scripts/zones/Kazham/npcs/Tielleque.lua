-----------------------------------
-- Area: Kazham
--  NPC: Tielleque
-- Type: Chocobo Renter
-- !pos -55.339 -9.999 -94.936 250
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 10016
local eventFail    = 10017

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
