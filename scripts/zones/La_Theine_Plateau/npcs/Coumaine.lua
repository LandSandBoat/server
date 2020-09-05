-----------------------------------
-- Area: La Theine Plateau
--  NPC: Coumaine
-- Type: Chocobo Vendor
-- !pos 441.782 24.231 20.254 102
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------

local eventSucceed = 120
local eventFail    = 121

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
