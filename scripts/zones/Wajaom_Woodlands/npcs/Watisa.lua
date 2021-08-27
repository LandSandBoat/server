-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: Watisa
-- Type: Chocobo Renter
-- !pos -201 -11 93 51
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------
local entity = {}

local eventSucceed = 9
local eventFail    = 10

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
