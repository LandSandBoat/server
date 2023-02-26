-----------------------------------
-- Area: Al'Taieu
--  Mob: Ul'xzomit
-----------------------------------
require("scripts/globals/follow")
require("scripts/globals/status")
-----------------------------------
local entity = {}

function entity.onMobSpawn(mob)
    local mobId = mob:getID()
    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()
    local r = mob:getRotPos()

    mob:setMobMod(xi.mobMod.ROAM_COOL, 0)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 50)

    local numFollowers = mob:getMobMod(xi.mobMod.LEADER)

    if numFollowers == 0 then
        mob:setMobFlags(1153)

        for i = 1, 2 do
            local leader = GetMobByID(mobId - i)

            if leader and leader:getMobMod(xi.mobMod.LEADER) >= i then
                mob:setLocalVar("leaderID", leader:getID())

                if leader:isSpawned() then
                    xi.follow.follow(mob, leader)
                end

                return
            end
        end
    else
        for i = 1, numFollowers do
            local follower = GetMobByID(mobId + i)

            if follower and follower:isSpawned() then
                xi.follow.follow(follower, mob)
            end
        end
    end
end

function entity.onMobFight(mob, target)
end

function entity.onMobEngaged(mob, target)
end

function entity.onMobDisengage(mob)
end

function entity.onMobRoam(mob)
end

-- Do the linking for the babies.
function entity.onMobRoamAction(mob)
    if mob:getMobMod(xi.mobMod.LEADER) > 0 then
        return
    end

    local leader = GetMobByID(mob:getLocalVar("leaderID"))

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

function entity.onMobDeath(mob, player, isKiller)
    if mob:getMobMod(xi.mobMod.LEADER) > 0 then
        xi.follow.clearFollowers(mob)
    end
end

return entity
