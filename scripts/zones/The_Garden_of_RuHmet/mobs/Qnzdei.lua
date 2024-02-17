-----------------------------------
-- Area: The Garden of Ru'Hmet
--  MOB: Aw'Zdei
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
mixins = { require('scripts/mixins/families/zdei') }
-----------------------------------
local entity = {}

entity.changeState = function(mob, idle)
    if mob:getLocalVar('idle') ~= idle then
        mob:setLocalVar('idle', idle)

        -- Calculate door id based off of mob id and door offset
        local doorID = ID.npc.QNZDEI_DOOR_OFFSET + (mob:getID() - ID.mob.QNZDEI_OFFSET) / 4
        local door = GetNPCByID(doorID)

        local doorIdle = door:getLocalVar('idle')
        if idle == 0 then
            doorIdle = math.max(0, doorIdle - 1)
        else
            doorIdle = math.min(doorIdle + 1, 4)
        end

        if doorIdle == 4 then
            door:setAnimation(xi.animation.OPEN_DOOR)
            door:setUntargetable(true)
        else
            door:setAnimation(xi.animation.CLOSE_DOOR)
            door:setUntargetable(false)
        end

        door:setLocalVar('idle', doorIdle)
    end
end

entity.onMobInitialize = function(mob)
end

local spinSpeeds = { 4, 8, 16, 64 }

entity.onMobSpawn = function(mob)
    entity.changeState(mob, 1)

    -- Qn'Zdei randomly spin at speeds 4, 8, 16, 64 and can be reversed (negative)
    mob:setLocalVar('spinSpeed', utils.randomEntry(spinSpeeds))
    if math.random(1, 2) == 1 then
        mob:setLocalVar('reversed', 1)
    end
end

entity.onMobEngage = function(mob, target)
    entity.changeState(mob, 0)
end

entity.onPath = function(mob)
    local spawnPos = mob:getSpawnPos()
    mob:pathThrough({ spawnPos.x, spawnPos.y, spawnPos.z })
    local pos = mob:getPos()
    if spawnPos.x == pos.x and spawnPos.z == pos.z then
        entity.changeState(mob, 1)

        local speed = mob:getLocalVar('spinSpeed')
        if mob:getLocalVar('reversed') == 1 then
            speed = -speed
        end

        mob:setPos(spawnPos.x, spawnPos.y, spawnPos.z, mob:getRotPos() + speed)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    entity.changeState(mob, 0)
end

return entity
