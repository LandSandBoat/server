-----------------------------------
-- Area: Xarcabard
--   NM: Boreal Hound
-- Involved in Quests: Atop the Highest Mountains
-- !pos -21 -25 -490 112
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
---@type TMobEntity
local entity = {}

local pathNodes =
{
    { x = -22.73, y = -24.65, z = -496.18 },
    { x = -19.06, y = -26,    z = -485.64 },
    { x = -19.69, y = -26,    z = -479.9 },
    { x = -19.82, y = -25.73, z = -473.84 },
    { x = -21.14, y = -26.26, z = -463.24 },
    { x = -22.73, y = -24.65, z = -496.18 },
    { x = -21.28, y = -25.58, z = -490.78 },
    { x = -19.06, y = -26,    z = -485.64 },
    { x = -19.69, y = -26,    z = -479.9 },
    { x = -19.82, y = -25.73, z = -473.84 },
    { x = -19.52, y = -26.4,  z = -467.73 },
    { x = -21.14, y = -26.26, z = -463.24 },
}

local baseSpeed = 60
local lookDelay = 600

-- recursive if mob is waiting at path point
local function rotateMob(mob)
    if mob:getSpeed() == 0 then
        local rotationDirection = mob:getLocalVar('rotationDirection')
        local rotationChange = 6

        if rotationDirection == 1 then
            rotationChange = -1 * rotationChange
        end

        if math.random() < .25 then
            rotationChange = 0
            mob:setLocalVar('rotationDirection', (rotationDirection + 1) % 2)
        end

        mob:setRotation((mob:getPos()['rot'] + rotationChange) % 256)
        mob:timer(lookDelay, function(mobArg)
            rotateMob(mobArg)
        end)
    end
end

entity.onPathPoint = function(mob)
    if math.random() < 0.5 then
        mob:setSpeed(0)
        mob:timer(math.random(4000, 8000), function(mobArg)
            mobArg:setSpeed(baseSpeed)
        end)

        mob:timer(lookDelay, function(mobArg)
            rotateMob(mobArg)
        end)
    end
end

entity.onMobRoam = function(mob)
    local pathingIndex = mob:getLocalVar('pathingIndex')

    if
        not mob:isFollowingPath() and
        mob:getSpeed() ~= 0
    then
        local pathFlag = xi.pathflag.SLIDE
        if math.random() < .5 then
            -- sometimes he runs between points
            mob:setSpeed(baseSpeed * 1.5)
            pathFlag = pathFlag + xi.pathflag.RUN
        end

        pathingIndex = (pathingIndex + 1) % #pathNodes + 1 -- Keep PathingIndex between the valid range
        mob:setLocalVar('pathingIndex', pathingIndex)
        mob:pathTo(pathNodes[pathingIndex].x, pathNodes[pathingIndex].y, pathNodes[pathingIndex].z, pathFlag)
    end
end

entity.onMobEngage = function(mob)
    mob:setSpeed(baseSpeed)
end

entity.onMobSpawn = function(mob)
    mob:setSpeed(baseSpeed)
    -- Failsafe to make sure NPC is down when NM is up
    if xi.settings.main.OLDSCHOOL_G2 then
        GetNPCByID(ID.npc.BOREAL_HOUND_QM):showNPC(0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if xi.settings.main.OLDSCHOOL_G2 then
        -- show ??? for desired duration
        -- notify people on the quest who need the KI
        GetNPCByID(ID.npc.BOREAL_HOUND_QM):showNPC(xi.settings.main.FRIGICITE_TIME)
        if
            not player:hasKeyItem(xi.ki.TRIANGULAR_FRIGICITE) and
            player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.ATOP_THE_HIGHEST_MOUNTAINS) == xi.questStatus.QUEST_ACCEPTED
        then
            player:messageSpecial(ID.text.BLOCKS_OF_ICE)
        end
    end
end

return entity
