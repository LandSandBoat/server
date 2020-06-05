-----------------------------------
-- Area: RuAun_Gardens
--  NPC: HomePoint#5
-- !pos 305 -42 -427 130
-----------------------------------
require("scripts/globals/homepoint")
-----------------------------------

local hpEvent = 8704
local hpIndex = 63

function onTrigger(player, npc)
    tpz.homepoint.onTrigger(player, hpEvent, hpIndex)
end

function onEventUpdate(player, csid, option)
    tpz.homepoint.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.homepoint.onEventFinish(player, csid, option, hpEvent)
end
