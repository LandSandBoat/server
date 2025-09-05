-----------------------------------
-- Area: Quicksand Caves
--   NM: Hastatus XI-XII
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -336.000, y = -0.500, z =  739.000 }
}

entity.phList =
{
    [ID.mob.HASTATUS_XI_XII - 4] = ID.mob.HASTATUS_XI_XII, -- -343.859 -0.411 751.608
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 650)
    mob:setMobMod(xi.mobMod.GIL_MAX, 1450)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
