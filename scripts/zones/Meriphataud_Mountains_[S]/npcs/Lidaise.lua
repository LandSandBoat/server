-----------------------------------
-- Area: Meriphataud Mountains [S]
--  NPC: Lidaise
-- Type: Chocobo Renter
-- !pos 312.021 -10.921 28.494 97
-----------------------------------
local entity = {}

local eventSucceed = 106
local eventFail    = 107

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
