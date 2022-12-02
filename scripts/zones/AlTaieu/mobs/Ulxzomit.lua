-----------------------------------
-- Area: Al'Taieu
--  Mob: Ul'xzomit
-----------------------------------
require("scripts/globals/follow")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    local mobId = mob:getID()
    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()
    local r = mob:getRotPos()

    if mob:getMobMod(xi.mobMod.LEADER) > 0 then
        for i = 1, mob:getMobMod(xi.mobMod.LEADER) do
            local followerId = mobId + i
            local follower = GetMobByID(followerId)

            if not follower:isSpawned() then
                local newX = x + math.random(-2, 2)
                local newY = y
                local newZ = z + math.random(-2, 2)

                follower:setSpawn(newX, newY, newZ, r)
                follower:spawn()
                follower:setMobFlags(1153)
            end

            xi.follow.follow(follower, mob)
        end
    end
end

entity.onMobEngaged = function(mob, target)
    local followers = xi.follow.getFollowers(mob)

    if not followers then
        return
    end

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
    local leader = xi.follow.getFollowTarget(mob)
    if
        not leader or
        not leader:isSpawned()
    then
        return
    end

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
end

return entity
