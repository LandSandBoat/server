-----------------------------------
-- Area: Port Jeuno
--  NPC: Narsha
-- Type: Chocobo Renter
-- !pos -2.51 8 -1 246
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------
local entity = {}

local eventSucceed = 10003
local eventFail    = 10006

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
