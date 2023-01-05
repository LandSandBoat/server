-----------------------------------
-- Area: The Garden of Ru'Hmet
--  MOB: Qn'Zdei
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
mixins = { require("scripts/mixins/families/zdei") }
-----------------------------------

local idleState =
{
    NOT_ON_PEDESTAL = 0,
    ON_PEDESTAL = 1
}

local spinSpeeds = { 4, 8, 16, 64 }

local checkDoorState = function(door)
    local doorIdle = door:getLocalVar("idle")
    if doorIdle == 4 then
        door:setAnimation(xi.animation.OPEN_DOOR)
        door:setUntargetable(true)
    else
        door:setAnimation(xi.animation.CLOSE_DOOR)
        door:setUntargetable(false)
    end
end

local updateIdleState = function(mob, idle)
    if mob:getLocalVar("idle") ~= idle then
        mob:setLocalVar("idle", idle)
        -- Calculate door id based off of mob id and door offset
        local mobOffset = mob:getID() - ID.mob.QNZDEI_OFFSET
        local doorOffset = 0
        if mobOffset ~= 0 then
            doorOffset = math.floor(mobOffset / 4)
        end

        local doorID = ID.npc.QNZDEI_DOOR_OFFSET + doorOffset
        local door = GetNPCByID(doorID)
        local doorIdle = door:getLocalVar("idle")

        if idle == 0 then
            doorIdle = math.max(doorIdle - 1, 0)
        else
            doorIdle = math.min(doorIdle + 1, 4)
        end

        door:setLocalVar("idle", doorIdle)
        checkDoorState(door)
    end
end

local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    updateIdleState(mob, idleState.ON_PEDESTAL)

    -- Qn'Zdei randomly spin at speeds 4, 8, 16, 64 and can be reversed (negative)
    mob:setLocalVar("spinSpeed", utils.randomEntry(spinSpeeds))
    if math.random(1, 2) == 1 then
        mob:setLocalVar("reversed", 1)
    end
end

entity.onMobEngaged = function(mob, target)
    updateIdleState(mob, idleState.NOT_ON_PEDESTAL)
end

entity.onPath = function(mob)
    local spawnPos = mob:getSpawnPos()
    mob:pathThrough({ spawnPos.x, spawnPos.y, spawnPos.z })
    local pos = mob:getPos()
    if spawnPos.x == pos.x and spawnPos.z == pos.z then
        updateIdleState(mob, idleState.ON_PEDESTAL)

        local speed = mob:getLocalVar("spinSpeed")
        if mob:getLocalVar("reversed") == 1 then
            speed = -speed
        end

        mob:setPos(spawnPos.x, spawnPos.y, spawnPos.z, mob:getRotPos() + speed)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    updateIdleState(mob, idleState.NOT_ON_PEDESTAL)
end

return entity
