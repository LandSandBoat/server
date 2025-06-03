-----------------------------------
-- Area: Lower Jeuno
--  NPC: Fephita
-- Type: Chocobo Renter
-- !pos -89.6 -0.100 -197.4 245
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
