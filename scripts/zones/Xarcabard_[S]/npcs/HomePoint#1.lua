-----------------------------------
-- Area: Xarcabard [S]
--  NPC: HomePoint#1
-- !pos 223 -13 -254 137
-----------------------------------
require("scripts/globals/homepoint")
-----------------------------------

local hpEvent = 8700
local hpIndex = 111

function onTrigger(player, npc)
    tpz.homepoint.onTrigger(player, hpEvent, hpIndex)
end

function onEventFinish(player, csid, option)
    tpz.homepoint.onEventFinish(player, csid, option, hpEvent)
end
