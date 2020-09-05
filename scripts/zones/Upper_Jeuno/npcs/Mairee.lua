-----------------------------------
-- Area: Upper Jeuno
--  NPC: Mairee
-- Type: Chocobo Renter
-- !pos -56.308 7.999 109.080 244
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------

local eventSucceed = 10002
local eventFail    = 10005

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
