require("scripts/globals/status")
require("scripts/globals/utils")

-----------------------------------
--
-- MOB FOLLOWING
--
-----------------------------------

xi = xi or {}
xi.follow = xi.follow or {}

local leaderToFollowersMap = {}
local followerToLeaderMap = {}
local followerOptions = {}

local addFollower
local cleanupFollower
local onMobRoamAction
local onMobDespawn

--- Change one mob's roaming behavior to persistently follow a target.
-- Will be reset when the mob or target despawns. A variety of options are available to configure the follow behavior.
-- Continuously follow an entity.
--
-- @param mob the mob that will be doing the following.
-- @param leader the target to follow.
-- @param @{ followOptions } options[opt] a table of configuration settings for the follow behavior.
--
-- @field followDistance[opt=5.0] in yalms, the preferred distance to the target to stay within.
-- @field separationAngle[opt=0.2] in radians, minimum separation to keep from other followers. 0.2 is roughly 1 yalm separation at 5 yalms distance.
-- @field pathFlags[opt=xi.pathflag.WALLHACK & xi.pathflag.SCRIPT] flags to pass to the pathTo() function.
-- @field roamCooldown[opt=false] in seconds, wait time between each new calculation of a follow path. false to leave unchanged.
-- @field warpDistance[opt=35.0] in yalms, distance at which the follower will teleport to the target. 0 to disable.
-- @table followOptions
-----------------------------------
function xi.follow.follow(mob, leader, options)
    if
        not leader:isSpawned() or
        not mob:isSpawned() or
        leader:getZoneID() ~= mob:getZoneID()
    then
        return false
    end

    options = options or {}
    options.followDistance = options.followDistance or 5.0
    options.separationAngle = options.separationAngle or 0.2
    options.pathFlags = options.pathFlags or bit.band(xi.pathflag.WALLHACK, xi.pathflag.SCRIPT)
    options.roamCooldown = options.roamCooldown or false
    options.warpDistance = options.warpDistance or 35.0

    addFollower(leader, mob, options)
end

function addFollower(leader, follower, options)
    local leaderId = leader:getID()
    local followerId = follower:getID()

    xi.follow.stopFollowing(follower)

    leaderToFollowersMap[leaderId] = leaderToFollowersMap[leaderId] or {}

    table.insert(leaderToFollowersMap[leaderId], follower)
    followerToLeaderMap[followerId] = leader

    follower:addListener("ROAM_ACTION", "FOLLOW_ROAM_ACTION", onMobRoamAction)
    follower:addListener("DESPAWN", "FOLLOW_DESPAWN", onMobDespawn)
    follower:setLocalVar("[follow]roamFlags", follower:getRoamFlags())
    follower:setLocalVar("[follow]DONT_ROAM_HOME", follower:getMobMod(xi.mobMod.DONT_ROAM_HOME))
    follower:setLocalVar("[follow]ROAM_COOL", follower:getMobMod(xi.mobMod.ROAM_COOL))
    follower:setRoamFlags(xi.roamFlag.SCRIPTED)
    follower:setMobMod(xi.mobMod.DONT_ROAM_HOME, 1)
    if options.roamCooldown then
        follower:setMobMod(xi.mobMod.ROAM_COOL, options.roamCooldown)
    end

    followerOptions[followerId] = options
end

function cleanupFollower(follower)
    followerOptions[follower:getID()] = nil
    follower:removeListener("FOLLOW_ROAM_ACTION")
    follower:removeListener("FOLLOW_DESPAWN")
    follower:setRoamFlags(follower:getLocalVar("[follow]roamFlags"))
    follower:setMobMod(xi.mobMod.DONT_ROAM_HOME, follower:getLocalVar("[follow]DONT_ROAM_HOME"))
    follower:setMobMod(xi.mobMod.ROAM_COOL, follower:getLocalVar("[follow]ROAM_COOL"))
end

function xi.follow.clearFollowers(leader)
    local followers = xi.follow.getFollowers(leader)

    if not followers or #followers == 0 then
        return
    end

    for _, follower in ipairs(followers) do
        xi.follow.stopFollowing(follower)
    end
end

function xi.follow.stopFollowing(follower)
    local followerId = follower:getID()
    local leader = followerToLeaderMap[followerId]

    if not leader then
        return
    end

    followerToLeaderMap[followerId] = nil
    local leaderId = leader:getID()

    if leaderToFollowersMap[leaderId] then
        for i, mob in ipairs(leaderToFollowersMap[leaderId]) do
            if mob:getID() == followerId then
                table.remove(leaderToFollowersMap[leaderId], i)
                break
            end
        end

        if #leaderToFollowersMap[leaderId] == 0 then
            leaderToFollowersMap[leaderId] = nil
        end
    end

    cleanupFollower(follower)
end

local function getAveragePos(mobsPos)
    if #mobsPos == 0 then
        return nil
    elseif #mobsPos == 1 then
        return mobsPos[1]
    end

    local count = #mobsPos
    local x = 0
    local y = 0
    local z = 0

    for _, mobPos in ipairs(mobsPos) do
        x = x + mobPos.x
        y = y + mobPos.y
        z = z + mobPos.z
    end

    return { x = x / count, y = y / count, z = z / count }
end

local function getAverageWorldAngle(origin, mobsPos)
    local pos = getAveragePos(mobsPos)
    return utils.getWorldAngle(origin, pos)
end

local function filterFollowersToPosArray(leaderPos, followerPos, followers, withinDistance, withinAngle)
    local filteredPos = {}

    for _, mob in ipairs(followers) do
        local mobPos = mob:getPos()

        if
            mob:isSpawned() and
            not utils.distanceWithin(leaderPos, mobPos, withinDistance, true) and
            utils.angleWithin(leaderPos, followerPos, mobPos, withinAngle)
        then
            table.insert(filteredPos, mobPos)
        end
    end

    return filteredPos
end

function onMobRoamAction(follower)
    local leader = xi.follow.getFollowTarget(follower)

    if
        not leader or
        not leader:isSpawned() or
        leader:getZoneID() ~= follower:getZoneID()
    then
        xi.follow.stopFollowing(follower)
        return
    end

    if follower:isFollowingPath() then
        return
    end
    
    local followerId = follower:getID()
    local leaderId = leader:getID()
    local options = followerOptions[followerId]
    local leaderPos = leader:getPos()
    local followerPos = follower:getPos()
    local followerDistance = utils.distance(leaderPos, followerPos)
    local followDistance = options.followDistance
    local warpDistance = options.warpDistance
    local separationAngle = options.separationAngle

    if followerDistance > followDistance + 1.0 then
        local followers = leaderToFollowersMap[leaderId]
        local followerIndex
        local followerCount = #followers

        for i, mob in ipairs(followers) do
            if mob:getID() == followerId then
                followerIndex = i
                break
            end
        end

        local filteredFollowersPos = filterFollowersToPosArray(leaderPos, followerPos, followers, followDistance, separationAngle)

        if #filteredFollowersPos == 1 then
            -- Ignore other followers, go straight to leader.
            local targetAngle = utils.getWorldAngle(leaderPos, followerPos)
            local targetPos = utils.getNearPosition(leaderPos, followDistance, targetAngle)

            follower:pathTo(targetPos.x, targetPos.y, targetPos.z)
        else
            -- Go to leader while leaving room for other followers.
            local targetAngle = getAverageWorldAngle(leaderPos, filteredFollowersPos)
            targetAngle = targetAngle + (separationAngle * (followerIndex - 1)) - (separationAngle * (followerCount - 1) / 2)
            local targetPos = utils.getNearPosition(leaderPos, followDistance, targetAngle)

            follower:pathTo(targetPos.x, targetPos.y, targetPos.z)
        end
    elseif warpDistance > 0 and followerDistance > warpDistance then
        follower:teleport(utils.getNearPosition(leaderPos, 2 + math.random() * (followDistance - 2), math.random() * 2 * math.pi), leader)
    end
end

function onMobDespawn(mob)
    xi.follow.stopFollowing(mob)
end

function xi.follow.getFollowers(leader)
    local followers = leaderToFollowersMap[leader:getID()]
    if not followers or #followers == 0 then
        return
    end

    local clone = {}
    for _, follower in ipairs(followers) do
        if follower then
            table.insert(clone, follower)
        end
    end

    return clone
end

function xi.follow.getFollowTarget(follower)
    return followerToLeaderMap[follower:getID()]
end
