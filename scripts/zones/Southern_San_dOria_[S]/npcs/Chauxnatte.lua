-----------------------------------
-- Area: Southern Sand'Oria [S]
--  NPC: Chauxnatte
-- Type: Chocobo Renter
-- !pos 85 1 -51 80
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------

local eventSucceed = 106
local eventFail    = 107

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
