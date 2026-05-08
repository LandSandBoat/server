-----------------------------------
-- Area: Newton Movalpolos
--  Mob: Moblin Aidman
-----------------------------------
mixins = { require('scripts/mixins/follow') }
local ID = zones[xi.zone.NEWTON_MOVALPOLOS]
-----------------------------------
---@type TMobEntity
local entity = {}

local leaders =
{
    [ID.mob.MOBLIN_AIDMAN[4]]  = -1,
    [ID.mob.MOBLIN_AIDMAN[6]]  = -1,
    [ID.mob.MOBLIN_AIDMAN[10]] = -1,
}

entity.onMobInitialize = function(mob)
    xi.follow.assignLeaderMod(mob, leaders, 1)
end

entity.onMobSpawn = function(mob)
    xi.follow.setFollowRange(mob, 2, 2)
end

return entity
