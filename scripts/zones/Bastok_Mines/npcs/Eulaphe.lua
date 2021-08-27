-----------------------------------
-- Area: Bastok Mines
--  NPC: Eulaphe
-- Type: Chocobo Renter
-- !pos 38.975 0.750 -108.629 234
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------
local entity = {}

local eventSucceed = 62
local eventFail    = 65

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.chocobo.renterOnTrigger(player, eventSucceed, eventFail)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.chocobo.renterOnEventFinish(player, csid, option, eventSucceed)
end

return entity
