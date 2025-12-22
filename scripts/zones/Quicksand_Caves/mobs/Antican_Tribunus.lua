-----------------------------------
-- Area: Quicksand Caves
--   NM: Antican Tribunus
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -582.000, y = -0.500, z = -412.000 }
}

entity.phList =
{
    [ID.mob.ANTICAN_TRIBUNUS + 18] = ID.mob.ANTICAN_TRIBUNUS, -- -575.455 -0.401 -433.802  TODO: Audit PH
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 3000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 432)
end

return entity
