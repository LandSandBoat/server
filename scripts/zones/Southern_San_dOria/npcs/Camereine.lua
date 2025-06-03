-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Camereine
-- Type: Chocobo Renter
-- !pos -12.3 1.4 -98 230
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 599
local eventFail    = 602

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
