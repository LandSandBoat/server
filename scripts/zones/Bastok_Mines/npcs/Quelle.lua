-----------------------------------
-- Area: Bastok Mines
--  NPC: Quelle
-- Type: Chocobo Renter
-- !pos 33.998 0.750 -108.625 234
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 63
local eventFail    = 66

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
