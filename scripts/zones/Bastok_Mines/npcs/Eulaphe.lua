-----------------------------------
-- Area: Bastok Mines
--  NPC: Eulaphe
-- Type: Chocobo Renter
-- !pos 38.975 0.750 -108.629 234
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------

local eventSucceed = 62
local eventFail    = 65

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.chocobo.renterOnTrigger(player, eventSucceed, eventFail)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.chocobo.renterOnEventFinish(player, csid, option, eventSucceed)
end
