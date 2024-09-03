-----------------------------------
-- Area: Al'Taieu
--  Mob: Om'xzomit
-----------------------------------
mixins = { require('scripts/mixins/follow') }
local ID = zones[xi.zone.ALTAIEU]
-----------------------------------
---@type TMobEntity
local entity = {}

local leaders =
{
    [ID.mob.OMXZOMIT_OFFSET[1]] = 2,
    [ID.mob.OMXZOMIT_OFFSET[4]] = 2,
    [ID.mob.OMXZOMIT_OFFSET[7]] = 2,
    [ID.mob.OMXZOMIT_OFFSET[10]] = 2,
    [ID.mob.OMXZOMIT_OFFSET[13]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[15]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[17]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[19]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[21]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[23]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[25]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[27]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[29]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[31]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[33]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[35]] = 2,
    [ID.mob.OMXZOMIT_OFFSET[38]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[40]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[42]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[44]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[46]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[48]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[50]] = 2,
    [ID.mob.OMXZOMIT_OFFSET[53]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[55]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[57]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[59]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[61]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[63]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[65]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[67]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[69]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[71]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[73]] = 1,
    [ID.mob.OMXZOMIT_OFFSET[75]] = 1,
}

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
