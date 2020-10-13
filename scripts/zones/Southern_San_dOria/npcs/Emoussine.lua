-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Emoussine
-- Type: Chocobo Renter
-- !pos -12.3 1.4 -98 230
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------

local eventSucceed = 600
local eventFail    = 603

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
