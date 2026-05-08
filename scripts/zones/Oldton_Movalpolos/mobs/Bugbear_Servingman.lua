-----------------------------------
-- Area: Oldton Movalpolos
--   Mob: Bugbear Servingman
-----------------------------------
mixins = { require('scripts/mixins/follow') }
local ID = zones[xi.zone.OLDTON_MOVALPOLOS]
-----------------------------------
---@type TMobEntity
local entity = {}

local leaders =
{
    [ID.mob.BUGBEAR_SERVINGMAN[5]] = -1,
    [ID.mob.BUGBEAR_SERVINGMAN[6]] = -1,
}

entity.onMobInitialize = function(mob)
    xi.follow.assignLeaderMod(mob, leaders, 2)
end

return entity
