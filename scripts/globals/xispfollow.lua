xi = xi or {}
xi.xispfollow = xi.xispfollow or {}

xi.xispfollow.getFollowTarget = function(pal)
    local player = GetPlayerByID(pal:getLocalVar('OwnerID'))
    local followers = xi.xispal.getFollowers(player)

    for followerIndex = #followers, 1, -1 do -- Loop through followers
        local follower = GetMobByID(followers[followerIndex])

        if follower and follower == pal then -- Ensure we only arrange logic for ourselves
            if followerIndex > 1 then -- if index == 1 then follow player
                local newIndex = followerIndex

                while newIndex > 1 do
                    local newLeader = GetMobByID(followers[newIndex - 1])

                    if newLeader and newLeader:isAlive() then
                        return newLeader
                    else
                        -- Loop to next eligible leader
                        newIndex = newIndex - 1
                    end
                end
            end
        end
    end

    return player -- Fallback onto player if no other leader was found
end

xi.xispfollow.follow = function(pal)
    local leader = xi.xispfollow.getFollowTarget(pal)
    local lPos   = leader:getPos()
    local posX, posZ = xi.xisp.getPointAroundLoc(lPos, 2, 2)
    local pos    = pal:getPos()
    local dist   = 10

    -- Fail safe: If player isn't logged in, despawn the pal
    if not GetPlayerByID(pal:getLocalVar('[XISP]ownerID')) then
        DespawnMob(pal:getID())
        return
    end

    -- Teleport to player if far away
    if pal:checkDistance(leader) > 40 then
        pal:setPos(posX, lPos.y, posZ)
    end

    -- Don't follow too close if player is in combat
    if leader:isEngaged() then
        dist = 20
    end

    -- Update movement parameters
    if pal:checkDistance(leader) > dist then
        pal:setLocalVar('isMoving', 1)
        pal:pathTo(posX, lPos.y, posZ, xi.path.flag.RUN)
    else
        pal:setLocalVar('isMoving', 0)
        pal:pathTo(pos.x, pos.y, pos.z)
    end
end