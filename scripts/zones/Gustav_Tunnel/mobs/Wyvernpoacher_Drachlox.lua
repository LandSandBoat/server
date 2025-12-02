-----------------------------------
-- Area: Gustav Tunnel
--   NM: Wyvernpoacher Drachlox
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.WYVERNPOACHER_DRACHLOX - 7] = ID.mob.WYVERNPOACHER_DRACHLOX, -- -100.000 1.000 -44.000
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 6000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 6000)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.TERROR)
end

return entity
