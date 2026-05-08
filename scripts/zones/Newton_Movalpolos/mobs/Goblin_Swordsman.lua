-----------------------------------
-- Area: Newton Movalpolos
--  Mob: Goblin Swordsman
-- Note: PH for Swashstox Beadblinker
-----------------------------------
local ID = zones[xi.zone.NEWTON_MOVALPOLOS]
-----------------------------------
---@type TMobEntity
local entity = {}

local followers =
{
    [ID.mob.GOBLIN_SWORDSMAN[1]] = 2,
    [ID.mob.GOBLIN_SWORDSMAN[2]] = 2,
    [ID.mob.GOBLIN_SWORDSMAN[3]] = 2,
}

entity.onMobInitialize = function(mob)
    xi.follow.assignLeaderMod(mob, followers, 2)
end

entity.onMobSpawn = function(mob)
    xi.follow.spawnFollowers(mob, followers)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SWASHSTOX_BEADBLINKER[1], 15, 10800)

    xi.follow.despawnFollowers(mob)
end

return entity
