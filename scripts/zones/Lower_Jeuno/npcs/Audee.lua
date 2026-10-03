-----------------------------------
-- Area: Lower Jeuno
--  NPC: Audee
-- Type: Chocobo Renter
-- !pos -89.6 -0.100 -197.4 245
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 10002
local eventFail    = 10005

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
