-----------------------------------
-- Area: Southern Sand'Oria [S]
--  NPC: Chauxnatte
-- Type: Chocobo Renter
-- !pos 85 1 -51 80
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------
local entity = {}

local eventSucceed = 106
local eventFail    = 107

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
