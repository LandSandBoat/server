-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Meuneille
-- Type: Chocobo Renter
-- !pos -16.233 1.548 -101.450 230
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 601
local eventFail    = 604

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
