-----------------------------------
-- Area: Al Zahbi
--  NPC: Dahaaba
-- Type: Chocobo Renter
-- !pos -65.309 -1 -39.585 48
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 270
local eventFail    = 271

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
