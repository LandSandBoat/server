-----------------------------------
-- Area: Oldton Movalpolos
--  Mob: Moblin Chapman
-----------------------------------
mixins = { require('scripts/mixins/follow') }
local ID = zones[xi.zone.OLDTON_MOVALPOLOS]
-----------------------------------
---@type TMobEntity
local entity = {}

local followers =
{
    [ID.mob.MOBLIN_CHAPMAN[3]] = 1,
}

entity.onMobInitialize = function(mob)
    xi.follow.assignLeaderMod(mob, followers, 2)
end

entity.onMobSpawn = function(mob)
    xi.follow.spawnFollowers(mob, followers)
end

entity.onMobDespawn = function(mob)
    xi.follow.despawnFollowers(mob)
end

return entity
