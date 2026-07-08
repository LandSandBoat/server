-----------------------------------
-- Area: Oldton Movalpolos
--  Mob: Moblin Gasman
-----------------------------------
mixins = { require('scripts/mixins/follow') }
local ID = zones[xi.zone.OLDTON_MOVALPOLOS]
-----------------------------------
---@type TMobEntity
local entity = {}

local leaders =
{
    [ID.mob.MOBLIN_GASMAN[2]] = -1,
    [ID.mob.MOBLIN_GASMAN[3]] = -1,
}

entity.onMobInitialize = function(mob)
    xi.follow.assignLeaderMod(mob, leaders, 1)
end

entity.onMobSpawn = function(mob)
    xi.follow.setFollowRange(mob, 2, 2)
end

return entity
