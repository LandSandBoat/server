-----------------------------------
-- Area: Al'Taieu
--  Mob: Ul'xzomit
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local followerToLeaderMap = {}
local leaderToFollowerMap = {}

function getNearPosition(origin, offset, angle)
    local radians = rotationToRadians(origin.rot) + angle
    local destination = {rotation=origin.rot}

    destination.x = origin.x + math.cos(2 * math.pi - radians) * offset
    destination.y = origin.y
    destination.z = origin.z + math.sin(2 * math.pi - radians) * offset

    return destination
end

local ffxiRotationToRadiansFactor = 2.0 * math.pi / 255.0

function rotationToRadians(ffxiRotation)
    return ffxiRotation * ffxiRotationToRadiansFactor
end

entity.onMobSpawn = function(mob)
    local mobId = mob:getID()
    local hpp = mob:getHPP()
    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()
    local r = mob:getRotPos()

    if mob:getMobMod(xi.mobMod.LEADER) > 0 then
        leaderToFollowerMap[mobId] = {}
        for i = 1, mob:getMobMod(xi.mobMod.LEADER) do
            local followerId = mobId + i
            local follower = GetMobByID(followerId)

            table.insert(leaderToFollowerMap[mobId], follower)
            followerToLeaderMap[followerId] = mob

            if not follower:isSpawned() then
                local newX = x + math.random(-2, 2)
                local newY = y
                local newZ = z + math.random(-2, 2)

                follower:setSpawn(newX, newY, newZ, r)
                follower:spawn()
                follower:setMobFlags(1153, followerId)
                follower:setRoamFlags(xi.roamFlag.SCRIPT)
                follower:setMobMod(xi.mobMod.ROAM_COOL, 2)
            end
        end
    end
end

entity.onMobEngaged = function(mob, target)
    local followers = leaderToFollowerMap[mob:getID()]

    if not followers then return end

    for _, follower in ipairs(followers) do
        if follower:isSpawned() and not follower:isEngaged() then
            follower:updateEnmity(target)
        end
    end
end

entity.onMobRoam = function(mob, player)
    -- TODO: Respawn followers?
    -- They might all stay dead until the entire group is killed, then respawn as a group.
end

-- Do the following and linking for the babies.
entity.onMobRoamAction = function(mob)
    local leader = followerToLeaderMap[mob:getID()]
    if not leader or not leader:isSpawned() then return end

    if leader:isEngaged() then
        local leaderTarget = leader:getTarget()
        if leaderTarget then
            mob:updateEnmity(leaderTarget)
            return
        end
    end

    if mob:isFollowingPath() then
        return
    end

    -- Follow behind by 8 yalms with a 1 yalm separation.
    local distance = mob:checkDistance(leader)
    local followDistance = 8.0
    local warpDistance = 35.0
    local separation = 1.0

    local followers = leaderToFollowerMap[leader:getID()]
    local followerCount = #followers
    local followerIndex = -1
    for i, follower in ipairs(followers) do
        if follower:getID() == mob:getID() then
            followerIndex = i
            break;
        end
    end

    if distance > followDistance + 1.0 then
        local origin = leader:getPos()
        local x = -followDistance + (-separation * 0.25 + math.random() * separation * 0.5)
        local z = (followerIndex - 1 - followerCount / 2.0) * separation + (-separation * 0.25 + math.random() * separation * 0.5)
        local targetLocation = utils.lateralTranslateWithOriginRotation(leader:getPos(), {x=x, z=z})
        targetLocation = getNearPosition(origin, followDistance, math.pi + (followerIndex - 1 - followerCount / 2.0) * separation / followDistance)

        if mob:checkDistance(targetLocation) > math.max(1.0, followDistance / 2.0) then
            mob:resetAI()
            mob:pathTo(targetLocation.x, targetLocation.y, targetLocation.z)
        end
    elseif distance > warpDistance then
        mob:teleport(getNearPosition(leader:getPos(), 1+math.random()*(followDistance-1), math.random() * 2 * math.pi), leader)
    else

    end
end

return entity

--[[
local ffxiRotConversionFactor = 360.0 / 255.0

function utils.ffxiRotToDegrees(ffxiRot)
    return ffxiRotConversionFactor * ffxiRot
end

function utils.lateralTranslateWithOriginRotation(origin, translation)
    local degrees = utils.ffxiRotToDegrees(origin.rot)
    local rads = math.rad(degrees)
    local new_coords = {}

    new_coords.x = origin.x + ((math.cos(rads) * translation.x) + (math.sin(rads) * translation.z))
    new_coords.z = origin.z + ((math.cos(rads) * translation.z) - (math.sin(rads) * translation.x))
    new_coords.y = origin.y
    new_coords.rot = origin.rot

    return new_coords
end

function getNearPosition(origin, offset, angle)
    local radians = rotationToRadians(origin.rot) + angle
    local destination = {rotation=origin.rot}

    destination.x = origin.x + math.cos(2 * math.pi - radians) * offset
    destination.y = origin.y
    destination.z = origin.z + math.sin(2 * math.pi - radians) * offset

    return destination
end

local ffxiRotationToRadiansFactor = 2.0 * math.pi / 255.0

function rotationToRadians(ffxiRotation)
    return ffxiRotation * ffxiRotationToRadiansFactor
end


// Stay behind the follow target.
float angle         = (float)M_PI;
uint16 followerCount = PTarget->objtype == TYPE_MOB ? ((CMobEntity*)PTarget)->getMobMod(MOBMOD_LEADER) : 0;

if (followerCount > 0 && PMob->id - PTarget->id <= followerCount)
{
    // Separate followers by 1 yalm.
    float separation = 1.0f / followDistance;
    angle += separation * (PMob->id - PTarget->id) - separation * followerCount / 2.0f;
}

position_t newPoint = nearPosition(PTarget->loc.p, followDistance, angle);

position_t nearPosition(const position_t& A, float offset, float radian)
{
    // PI * 0.75 offsets the rotation to the proper place
    float      totalRadians = rotationToRadian(A.rotation) + radian;
    position_t B;

    B.x = A.x + cosf((float)(2 * M_PI - totalRadians)) * offset;
    B.y = A.y;
    B.z = A.z + sinf((float)(2 * M_PI - totalRadians)) * offset;

    B.rotation = A.rotation;
    B.moving   = A.moving;

    return B;
}
--]]