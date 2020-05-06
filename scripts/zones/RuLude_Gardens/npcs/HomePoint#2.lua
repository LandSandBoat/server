-----------------------------------
-- Area: RuLude_Gardens
--  NPC: HomePoint#2
-- !pos 53 9 -57 243
-----------------------------------
require("scripts/globals/homepoint")
-----------------------------------

local hpEvent = 8701
local hpIndex = 30

function onTrigger(player, npc)
    tpz.homepoint.onTrigger(player, hpEvent, hpIndex)
end

function onEventUpdate(player, csid, option)
    tpz.homepoint.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.homepoint.onEventFinish(player, csid, option, hpEvent)
end
