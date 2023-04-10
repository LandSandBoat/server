-----------------------------------
-- Area: Fort Ghelsba
--  NPC: Elevator Lever (lower)
-- !pos  -0.652 -28.996 100.445 141
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- local vars to reduce repeat calls..
    local lever = npc:getID()
    local gear = GetNPCByID(lever + 2)
    local bigWinch = GetNPCByID(lever - 1)

    -- Animate lever
    npc:openDoor(1)

    -- Animate lever's Gear - do not use openDoor() / closeDoor() here!
    if gear:getAnimation() == xi.animation.OPEN_DOOR then
        gear:setAnimation(xi.animation.CLOSE_DOOR)
    else
        gear:setAnimation(xi.animation.OPEN_DOOR)
    end

    -- Animate bigWinch - do not use openDoor() / closeDoor() here!
    if bigWinch:getAnimation() == xi.animation.OPEN_DOOR then
        bigWinch:setAnimation(xi.animation.CLOSE_DOOR)
    else
        bigWinch:setAnimation(xi.animation.OPEN_DOOR)
    end

    -- Move platform
    RunElevator(xi.elevator.FORT_GHELSBA_LIFT)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
