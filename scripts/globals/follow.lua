require('scripts/globals/utils')

-----------------------------------
--
-- MOB FOLLOWING
--
-----------------------------------
xi = xi or {}
xi.follow = xi.follow or {}

local function onMobDespawn(mob)
    xi.follow.stopFollowing(mob)
end

--- Change one mob's roaming behavior to persistently follow a target.
-- Will be reset when the mob or target despawns.
--
-- @param follower the mob that will be doing the following.
-- @param leader the target entity to follow.
-----------------------------------
xi.follow.follow = function(follower, leader)
    if
        not leader:isSpawned() or
        not follower:isSpawned() or
        leader:getZoneID() ~= follower:getZoneID()
    then
        return false
    end

    local leaderID = leader:getID()
    if leaderID == follower:getLocalVar('leaderID') then
        return true
    end

    xi.follow.stopFollowing(follower)
    follower:follow(leader, xi.followType.ROAM)
    follower:addListener('DESPAWN', 'FOLLOW_DESPAWN', onMobDespawn)
    follower:setLocalVar('leaderID', leaderID)
end

xi.follow.clearFollowers = function(leader)
    local followers = xi.follow.getFollowers(leader)
    if not followers then
        return
    end

    for _, follower in ipairs(followers) do
        xi.follow.stopFollowing(follower)
    end
end

xi.follow.stopFollowing = function(follower)
    if follower:getLocalVar('leaderID') == 0 then
        return
    end

    follower:unfollow()
    follower:removeListener('FOLLOW_DESPAWN')
    follower:setLocalVar('leaderID', 0)
end

xi.follow.getFollowers = function(leader)
    local leaderMod = leader:getMobMod(xi.mobMod.LEADER)
    if leaderMod <= 0 then
        return nil
    end

    local followers = {}
    local leaderID = leader:getID()
    for id = leaderID + 1, leaderID + leaderMod do
        table.insert(followers, GetMobByID(id))
    end

    return followers
end

xi.follow.getLeader = function(follower)
    local leaderMod = follower:getMobMod(xi.mobMod.LEADER)
    if leaderMod >= 0 then
        return nil
    end

    return GetMobByID(follower:getID() - leaderMod)
end

xi.follow.assignLeaderMod = function(mob, leaders, maxDistance)
    local mobID = mob:getID()
    local followerCount = leaders[mobID]
    if followerCount ~= nil then
        mob:setMobMod(xi.mobMod.LEADER, followerCount)
        return
    end

    for distanceFromLeader = 1, maxDistance do
        local leaderID = mobID - distanceFromLeader
        if leaders[leaderID] ~= nil then
            mob:setMobMod(xi.mobMod.LEADER, -distanceFromLeader)
            return
        end
    end
end
