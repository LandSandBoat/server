-----------------------------------
-- Area: La Vaule [S]
--   NM: Ashmaker Gotblut
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.LA_VAULE_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  137.606, y =  3.346, z = -279.050 }
}

entity.phList =
{
    [ID.mob.ASHMAKER_GOTBLUT - 2] = ID.mob.ASHMAKER_GOTBLUT, -- 234.481 3.424 -241.751
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
