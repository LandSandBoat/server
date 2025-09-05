-----------------------------------
-- Area: Quicksand Caves
--   NM: Antican Proconsul
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  76.000, y = -0.600, z = -194.000 }
}

entity.phList =
{
    [ID.mob.ANTICAN_PROCONSUL - 1] = ID.mob.ANTICAN_PROCONSUL, -- 89.575 -0.299 -196.206
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 2100)
    mob:setMobMod(xi.mobMod.GIL_MAX, 4500)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 430)
end

return entity
