-----------------------------------
-- Area: Lower Jeuno
--  NPC: Fephita
-- Type: Chocobo Renter
-- !pos -89.6 -0.100 -197.4 245
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------
local entity = {}

local eventSucceed = 10003
local eventFail    = 10006

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.chocobo.renterOnTrigger(player, eventSucceed, eventFail)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    tpz.chocobo.renterOnEventFinish(player, csid, option, eventSucceed)
end

return entity
