-----------------------------------
-- Area: Oldton Movalpolos
--  Mob: Goblin Pikeman
-----------------------------------
mixins = { require('scripts/mixins/follow') }
local ID = zones[xi.zone.OLDTON_MOVALPOLOS]
-----------------------------------
---@type TMobEntity
local entity = {}

local leaders =
{
    [ID.mob.MOBLIN_PIKEMAN[3]] = -3,
    [ID.mob.MOBLIN_PIKEMAN[4]] = -3,
}

entity.onMobInitialize = function(mob)
    xi.follow.assignLeaderMod(mob, leaders, 3)
end

entity.onMobSpawn = function(mob)
    xi.follow.setFollowRange(mob, 4, 4)
end

return entity
