-----------------------------------
-- Area: Norg
--  NPC: Marilleune
-- Type: Chocobo Renter
-- !pos -11.309 -0.749 -51.162 252
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------
local entity = {}

local eventSucceed = 131
local eventFail    = 132

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
