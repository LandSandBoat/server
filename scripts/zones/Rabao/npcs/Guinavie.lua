-----------------------------------
-- Area: Rabao
--  NPC: Guinavie
-- Type: Chocobo Vendor
-- !pos 6.666 -0.515 -77.944 247
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------

local eventSucceed = 79
local eventFail    = 80

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
