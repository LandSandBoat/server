-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Qn'Zdei
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
mixins = { require('scripts/mixins/families/zdei') }
-----------------------------------
---@type TMobEntity
local entity = {}

local subLinkTable =
{
    [ID.mob.QNZDEI_OFFSET]      = 1000,
    [ID.mob.QNZDEI_OFFSET + 1]  = 1000,
    [ID.mob.QNZDEI_OFFSET + 2]  = 1000,
    [ID.mob.QNZDEI_OFFSET + 3]  = 1000,
    [ID.mob.QNZDEI_OFFSET + 4]  = 1001,
    [ID.mob.QNZDEI_OFFSET + 5]  = 1001,
    [ID.mob.QNZDEI_OFFSET + 6]  = 1001,
    [ID.mob.QNZDEI_OFFSET + 7]  = 1001,
    [ID.mob.QNZDEI_OFFSET + 8]  = 1002,
    [ID.mob.QNZDEI_OFFSET + 9]  = 1002,
    [ID.mob.QNZDEI_OFFSET + 10] = 1002,
    [ID.mob.QNZDEI_OFFSET + 11] = 1002,
    [ID.mob.QNZDEI_OFFSET + 12] = 1003,
    [ID.mob.QNZDEI_OFFSET + 13] = 1003,
    [ID.mob.QNZDEI_OFFSET + 14] = 1003,
    [ID.mob.QNZDEI_OFFSET + 15] = 1003,
}

entity.onMobInitialize = function(mob)
    local subLinkValue = subLinkTable[mob:getID()]

    if subLinkValue then
        mob:setMobMod(xi.mobMod.SUBLINK, subLinkValue)
    end
end

local changeState = function(mob, idle)
    if mob:getLocalVar('idle') ~= idle then
        mob:setLocalVar('idle', idle)

        -- Calculate door id based off of mob id and door offset
        local doorID = math.floor(ID.npc.QNZDEI_DOOR_OFFSET + (mob:getID() - ID.mob.QNZDEI_OFFSET) / 4)
        local door   = GetNPCByID(doorID)

        if door then
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
end

local spinSpeeds = { 4, 8, 16, 64 }

entity.onMobSpawn = function(mob)
    changeState(mob, 1)

    -- Qn'Zdei randomly spin at speeds 4, 8, 16, 64 and can be reversed (negative)
    mob:setLocalVar('spinSpeed', utils.randomEntry(spinSpeeds))
    if math.random(1, 100) <= 50 then
        mob:setLocalVar('reversed', 1)
    end
end

entity.onMobEngage = function(mob, target)
    changeState(mob, 0)
end

entity.onPath = function(mob)
    local spawnPos = mob:getSpawnPos()
    mob:pathThrough({ spawnPos.x, spawnPos.y, spawnPos.z })
    local pos = mob:getPos()
    if spawnPos.x == pos.x and spawnPos.z == pos.z then
        changeState(mob, 1)

        local speed = mob:getLocalVar('spinSpeed')
        if mob:getLocalVar('reversed') == 1 then
            speed = -speed
        end

        mob:setPos(spawnPos.x, spawnPos.y, spawnPos.z, mob:getRotPos() + speed)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    changeState(mob, 0)
end

return entity
