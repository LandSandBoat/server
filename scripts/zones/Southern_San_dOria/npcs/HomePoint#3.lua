-----------------------------------
-- Area: Southern San dOria
--  NPC: HomePoint#3
-- !pos 140 -2 123 230
-----------------------------------
require("scripts/globals/homepoint")
-----------------------------------

local hpEvent = 8702
local hpIndex = 2

function onTrigger(player, npc)
    tpz.homepoint.onTrigger(player, hpEvent, hpIndex)
end

function onEventUpdate(player, csid, option)
    tpz.homepoint.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.homepoint.onEventFinish(player, csid, option, hpEvent)
end
