-----------------------------------
-- Area: Davoi
--  NPC: _452 (Elevator Lever)
-- Notes: Used to operate Elevator @450 (actual npc script is _454)
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    npc:openDoor(3) -- lever animation
    RunElevator(tpz.elevator.DAVOI_LIFT) -- elevator @450 (actual npc script is _454)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
end
