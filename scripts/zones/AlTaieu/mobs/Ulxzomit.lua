-----------------------------------
-- Area: Al'Taieu
--  Mob: Ul'xzomit
-----------------------------------
local entity = {}

local followOptions = { forceRepathInterval = 1 }

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ROAM_COOL, 0)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 50)

    local mobId = mob:getID()
    local numFollowers = mob:getMobMod(xi.mobMod.LEADER)

    if numFollowers == 0 then
        -- Baby Ul'xzomit
        mob:setMobFlags(1153)

        for i = 1, 2 do
            local leader = GetMobByID(mobId - i)

            if leader and leader:getMobMod(xi.mobMod.LEADER) >= i then
                mob:setLocalVar('leaderID', leader:getID())

                if leader:isSpawned() then
                    xi.follow.follow(mob, leader, followOptions)
                end

                return
            end
        end
    else
        -- Mother Ul'xzomit
        for i = 1, numFollowers do
            local follower = GetMobByID(mobId + i)

            if follower and follower:isSpawned() then
                xi.follow.follow(follower, mob, followOptions)
            end
        end
    end
end

-- Do the linking for the babies.
entity.onMobRoamAction = function(mob)
    if mob:getMobMod(xi.mobMod.LEADER) > 0 then
        return
    end

    local leader = GetMobByID(mob:getLocalVar('leaderID'))

    if not leader or not leader:isSpawned() then
        return
    end

    if leader:isEngaged() and leader:checkDistance(mob) <= 8 then
        local leaderTarget = leader:getTarget()

        if leaderTarget then
            mob:updateEnmity(leaderTarget)
            return
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if mob:getMobMod(xi.mobMod.LEADER) > 0 then
        xi.follow.clearFollowers(mob)
    end
end

return entity
