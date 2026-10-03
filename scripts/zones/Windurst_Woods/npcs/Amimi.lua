-----------------------------------
-- Area: Windurst Woods
--  NPC: Amimi
-- Type: Chocobo Renter
-- !pos 133.24 -5.250 -126.76 241
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 10004
local eventFail    = 10007

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
