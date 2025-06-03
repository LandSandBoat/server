-----------------------------------
-- Area: Upper Jeuno
--  NPC: Couvoullie
-- Type: Chocobo Renter
-- !pos -58.435 7.999 113.210 244
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 10003
local eventFail    = 10006

entity.onTrade = function(player, npc, trade)
    xi.chocobo.renterOnTrade(player, npc, trade, eventSucceed, eventFail)
end

entity.onTrigger = function(player, npc)
    xi.chocobo.renterOnTrigger(player, npc, eventSucceed, eventFail)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocobo.renterOnEventFinish(player, csid, option, eventSucceed)
end

return entity
