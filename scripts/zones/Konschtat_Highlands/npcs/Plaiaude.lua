-----------------------------------
-- Area: Konschtat Highlands
--  NPC: Plaiaude
-- Type: Chocobo Renter
-- !pos 244.705 24.034 296.973 108
-----------------------------------
local entity = {}

local eventSucceed = 910
local eventFail    = 911

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.chocobo.renterOnTrigger(player, eventSucceed, eventFail)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocobo.renterOnEventFinish(player, csid, option, eventSucceed)
end

return entity
