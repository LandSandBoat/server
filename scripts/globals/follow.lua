-----------------------------------
-- MOB FOLLOWING
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
---@param follower CBaseEntity
---@param leader CBaseEntity
---@return boolean|nil
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

---@param leader CBaseEntity
xi.follow.clearFollowers = function(leader)
    local followers = xi.follow.getFollowers(leader)
    if not followers then
        return
    end

    for _, follower in ipairs(followers) do
        xi.follow.stopFollowing(follower)
    end
end

---@param leader CBaseEntity
---@param followers table<integer, integer> -- [leaderID] = followerCount
xi.follow.spawnFollowers = function(leader, followers)
    local followerCount = followers[leader:getID()] or 0

    if followerCount > 0 then
        for i = 1, followerCount do
            local followerID     = leader:getID() + i
            local followerEntity = GetMobByID(followerID)

            if
                followerEntity and
                not followerEntity:isSpawned()
            then
                SpawnMob(followerID)
            end
        end
    end
end

---@param leader CBaseEntity
xi.follow.despawnFollowers = function(leader)
    local followerEntity = xi.follow.getFollowers(leader)

    if followerEntity then
        for _, follower in ipairs(followerEntity) do
            if
                follower and
                follower:isSpawned() and
                not follower:isEngaged()
            then
                DespawnMob(follower:getID())
            end
        end
    end
end

---@param follower CBaseEntity
xi.follow.stopFollowing = function(follower)
    if follower:getLocalVar('leaderID') == 0 then
        return
    end

    follower:unfollow()
    follower:removeListener('FOLLOW_DESPAWN')
    follower:setLocalVar('leaderID', 0)
end

---@param leader CBaseEntity
---@return CBaseEntity[]|nil
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

---@param follower CBaseEntity
---@return CBaseEntity|nil
xi.follow.getLeader = function(follower)
    local leaderMod = follower:getMobMod(xi.mobMod.LEADER)
    if leaderMod >= 0 then
        return nil
    end

    return GetMobByID(follower:getID() - leaderMod)
end

---@param mob CBaseEntity
---@param leaders table<integer, integer> -- [leaderID] = followerCount
---@param maxDistance integer
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

---@param mob CBaseEntity
---@param followRange number
---@param stopRange number
xi.follow.setFollowRange = function(mob, followRange, stopRange)
    if mob:getMobMod(xi.mobMod.LEADER) < 0 then -- Is a follower
        mob:setMobMod(xi.mobMod.FOLLOW_LEASH_RANGE, followRange)
        mob:setMobMod(xi.mobMod.FOLLOW_STOP_RANGE, stopRange)
    end
end
