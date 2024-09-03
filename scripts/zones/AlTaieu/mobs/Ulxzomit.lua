-----------------------------------
-- Area: Al'Taieu
--  Mob: Ul'xzomit
-----------------------------------
mixins = { require('scripts/mixins/follow') }
local ID = zones[xi.zone.ALTAIEU]
-----------------------------------
---@type TMobEntity
local entity = {}

local leaders = {}
for i = 0, 14 do
    leaders[ID.mob.ULXZOMIT_OFFSET[1 + i * 3]] = 2
end

entity.onMobInitialize = function(mob)
    xi.follow.assignLeaderMod(mob, leaders, 2)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ROAM_COOL, 0)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 50)

    -- Baby Ul'xzomit
    if mob:getMobMod(xi.mobMod.LEADER) < 0 then
        mob:setMobFlags(1153)
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
end

return entity
