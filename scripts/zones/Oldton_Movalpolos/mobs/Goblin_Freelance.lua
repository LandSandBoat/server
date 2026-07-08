-----------------------------------
-- Area: Oldton Movalpolos
--  Mob: Goblin Freelance
-----------------------------------
local ID = zones[xi.zone.OLDTON_MOVALPOLOS]
-----------------------------------
---@type TMobEntity
local entity = {}

local followers =
{
    [ID.mob.GOBLIN_FREELANCE[1]] = 3,
    [ID.mob.GOBLIN_FREELANCE[2]] = 3,
}

entity.onMobInitialize = function(mob)
    xi.follow.assignLeaderMod(mob, followers, 3)
end

entity.onMobSpawn = function(mob)
    xi.follow.spawnFollowers(mob, followers)
end

entity.onMobDespawn = function(mob)
    xi.follow.despawnFollowers(mob)
end

return entity
