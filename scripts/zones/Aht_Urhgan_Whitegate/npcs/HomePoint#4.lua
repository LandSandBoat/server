-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: HomePoint#4
-- !pos -99 -6 -68 50
-----------------------------------
require("scripts/globals/homepoint")
-----------------------------------

local hpEvent = 8703
local hpIndex = 108

function onTrigger(player, npc)
    tpz.homepoint.onTrigger(player, hpEvent, hpIndex)
end

function onEventUpdate(player, csid, option)
    tpz.homepoint.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.homepoint.onEventFinish(player, csid, option, hpEvent)
end
