-----------------------------------
-- Area: Quicksand Caves
--   NM: Antican Praefectus
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  869.240, y =  1.045, z = -655.214 }
}

entity.phList =
{
    [ID.mob.ANTICAN_PRAEFECTUS - 1] = ID.mob.ANTICAN_PRAEFECTUS, -- -90.01 -0.567 -29.424
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 2100)
    mob:setMobMod(xi.mobMod.GIL_MAX, 4500)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 431)
end

return entity
