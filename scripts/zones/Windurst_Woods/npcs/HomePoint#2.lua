-----------------------------------
-- Area: Windurst Woods
--  NPC: HomePoint#2
-- !pos 107 -5 -56 241
-----------------------------------
require("scripts/globals/homepoint")
-----------------------------------

local hpEvent = 8701
local hpIndex = 26

function onTrigger(player, npc)
    tpz.homepoint.onTrigger(player, hpEvent, hpIndex)
end

function onEventUpdate(player, csid, option)
    tpz.homepoint.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.homepoint.onEventFinish(player, csid, option, hpEvent)
end
