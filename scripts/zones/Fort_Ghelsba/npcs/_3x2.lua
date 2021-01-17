-----------------------------------
-- Area: Fort Ghelsba
--  NPC: Elevator Lever (upper)
-- !pos  8.112 -52.665 96.084 141
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- local vars to reduce repeat calls..
    local lever = npc:getID()
    local gear = GetNPCByID(lever +2)
    local bigWinch = GetNPCByID(lever -2)

    -- Animate lever
    npc:openDoor(1)

    -- Animate lever's Gear - do not use openDoor() / closeDoor() here!
    if gear:getAnimation() == tpz.animation.OPEN_DOOR then
        gear:setAnimation(tpz.animation.CLOSE_DOOR)
    else
        gear:setAnimation(tpz.animation.OPEN_DOOR)
    end

    -- Animate bigWinch - do not use openDoor() / closeDoor() here!
    if bigWinch:getAnimation() == tpz.animation.OPEN_DOOR then
        bigWinch:setAnimation(tpz.animation.CLOSE_DOOR)
    else
        bigWinch:setAnimation(tpz.animation.OPEN_DOOR)
    end

    -- Move platform
    RunElevator(tpz.elevator.FORT_GHELSBA_LIFT)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
