-----------------------------------
-- Area: Bastok Mines
--  NPC: Eulaphe
-- Type: Chocobo Renter
-- !pos 38.975 0.750 -108.629 234
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 62
local eventFail    = 65

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
