xi = xi or {}
xi.xispfollow = xi.xispfollow or {}

xi.xispfollow.getFollowTarget = function(pal, player)
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

xi.xispfollow.follow = function(pal, player)
    local leader = xi.xispfollow.getFollowTarget(pal, player)
    local lPos   = leader:getPos()
    local posX, posZ = xi.xisp.getPointAroundLoc(lPos, 2, 2)
    local pos    = pal:getPos()
    local dist   = 6
    local job    = pal:getMainJob()

    -- Fail safe: If player isn't logged in, despawn the pal
    if not GetPlayerByID(pal:getLocalVar('[XISP]ownerID')) then
        DespawnMob(pal:getID())
        return
    end

    if player:hasStatusEffect(xi.effect.MOUNTED) then
        dist = 8
    end

    -- Teleport to player if far away
    if pal:checkDistance(leader) > 40 then
        pal:setPos(posX, lPos.y, posZ)
    end

    -- Below commented out code is for custom pals and not chocobos

    -- Engagement Handling (Update enmity if leader player is in combat)
    -- if player:isEngaged() then
    --     local target = player:getTarget()

    --     for _, mob in pairs(player:getNotorietyList()) do
    --         if mob:isMob() and mob == target then
    --             if
    --                 job ~= xi.job.WHM and
    --                 job ~= xi.job.BLM and
    --                 job ~= xi.job.SMN and
    --                 job ~= xi.job.BRD and
    --                 pal:getLocalVar('[XISP]isChocobo') ~= 1
    --             then
    --                 pal:updateEnmity(target)
    --             end
    --         end
    --     end
    -- end


    -- Update movement parameters
    -- if
    --     pal:checkDistance(leader) > dist and
    --     not pal:hasStatusEffect(xi.effect.HEALING) and
    --     pal:getCurrentAction() ~= xi.action.MAGIC_CASTING
    -- then
    --     pal:setLocalVar('isMoving', 1)
    --     pal:pathTo(posX, lPos.y, posZ, xi.path.flag.RUN)
    -- else
    --     pal:setLocalVar('isMoving', 0)
    --     pal:pathTo(pos.x, pos.y, pos.z)
    -- end
end