-----------------------------------
-- Area: The Boyahda Tree
--  NPC: HomePoint#1
-- !pos 88 -15 -217 153
-----------------------------------
require("scripts/globals/homepoint")
-----------------------------------

local hpEvent = 8700
local hpIndex = 92

function onTrigger(player, npc)
    tpz.homepoint.onTrigger(player, hpEvent, hpIndex)
end

function onEventUpdate(player, csid, option)
    tpz.homepoint.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.homepoint.onEventFinish(player, csid, option, hpEvent)
end
