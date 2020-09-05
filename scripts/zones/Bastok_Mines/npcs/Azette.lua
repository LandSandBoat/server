-----------------------------------
-- Area: Bastok Mines
--  NPC: Azette
-- Type: Chocobo Renter
-- !pos 43.882 0.750 -108.629 234
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------

local eventSucceed = 61
local eventFail    = 64

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
