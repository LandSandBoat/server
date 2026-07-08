-----------------------------------
-- Area: Newton Movalpolos
--  Mob: Moblin Topsman
-----------------------------------
mixins = { require('scripts/mixins/follow') }
local ID = zones[xi.zone.NEWTON_MOVALPOLOS]
-----------------------------------
---@type TMobEntity
local entity = {}

local leaders =
{
    [ID.mob.MOBLIN_TOPSMAN[4]] = -2,
}

entity.onMobInitialize = function(mob)
    xi.follow.assignLeaderMod(mob, leaders, 2)
end

entity.onMobSpawn = function(mob)
    xi.follow.setFollowRange(mob, 3, 3)
end

return entity
