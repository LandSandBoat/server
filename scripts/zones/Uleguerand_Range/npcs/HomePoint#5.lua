-----------------------------------
-- Area: Uleguerand_Range
--  NPC: HomePoint#5
-----------------------------------
require("scripts/globals/homepoint")
-----------------------------------

local hpEvent = 8704
local hpIndex = 80

function onTrigger(player, npc)
    tpz.homepoint.onTrigger(player, hpEvent, hpIndex)
end

function onEventUpdate(player, csid, option)
    tpz.homepoint.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.homepoint.onEventFinish(player, csid, option, hpEvent)
end
