-----------------------------------
-- Area: Southern_San_dOria_[S]
--  NPC: HomePoint#1
-- !pos -85.468 1.000 -66.454 80
-----------------------------------
require("scripts/globals/homepoint")
-----------------------------------

local hpEvent = 8700
local hpIndex = 68

function onTrigger(player, npc)
    tpz.homepoint.onTrigger(player, hpEvent, hpIndex)
end

function onEventUpdate(player, csid, option)
    tpz.homepoint.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.homepoint.onEventFinish(player, csid, option, hpEvent)
end
