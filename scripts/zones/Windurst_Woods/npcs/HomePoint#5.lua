-----------------------------------
-- Area: Windurst Woods
--  NPC: HomePoint#5
-- !pos -43.5 0 -145 241
-----------------------------------
require("scripts/globals/homepoint")
-----------------------------------

local hpEvent = 8704
local hpIndex = 119

function onTrigger(player, npc)
    tpz.homepoint.onTrigger(player, hpEvent, hpIndex)
end

function onEventUpdate(player, csid, option)
    tpz.homepoint.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.homepoint.onEventFinish(player, csid, option, hpEvent)
end
