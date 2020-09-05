-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Yasmina
-- Type: Chocobo Renter
-- !pos -34.972 -5.815 221.845 94
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------

local eventSucceed = 6
local eventFail    = 7

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
