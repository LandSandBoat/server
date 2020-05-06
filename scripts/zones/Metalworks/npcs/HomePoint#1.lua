-----------------------------------
-- Area: Metalworks
--  NPC: HomePoint#1
-- !pos 46 -14 -19 237
-----------------------------------
require("scripts/globals/homepoint")
-----------------------------------

local hpEvent = 8700
local hpIndex = 16

function onTrigger(player, npc)
    tpz.homepoint.onTrigger(player, hpEvent, hpIndex)
end

function onEventUpdate(player, csid, option)
    tpz.homepoint.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.homepoint.onEventFinish(player, csid, option, hpEvent)
end
