-----------------------------------
-- Area: Konschtat Highlands
--  NPC: Plaiaude
-- Type: Chocobo Renter
-- !pos 244.705 24.034 296.973 108
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 910
local eventFail    = 911

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
