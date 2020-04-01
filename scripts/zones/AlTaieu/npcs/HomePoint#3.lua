-----------------------------------
-- Area: AlTaieu
--  NPC: HomePoint#3
-- !pos 569 0 410 33
-----------------------------------
require("scripts/globals/homepoint")
-----------------------------------

local hpEvent = 8702
local hpIndex = 87

function onTrigger(player, npc)
    tpz.homepoint.onTrigger(player, hpEvent, hpIndex)
end

function onEventUpdate(player, csid, option)
    tpz.homepoint.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.homepoint.onEventFinish(player, csid, option, hpEvent)
end
