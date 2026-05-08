-----------------------------------
-- Area: Oldton Movalpolos
--  Mob: Moblin Coalman
-----------------------------------
mixins = { require('scripts/mixins/follow') }
local ID = zones[xi.zone.OLDTON_MOVALPOLOS]
-----------------------------------
---@type TMobEntity
local entity = {}

local leaders =
{
    [ID.mob.MOBLIN_COALMAN[2]] = -2,
    [ID.mob.MOBLIN_COALMAN[3]] = -2,
}

entity.onMobInitialize = function(mob)
    xi.follow.assignLeaderMod(mob, leaders, 2)
end

entity.onMobSpawn = function(mob)
    xi.follow.setFollowRange(mob, 3, 3)
end

return entity
