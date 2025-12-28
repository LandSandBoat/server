-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Aa Xalmo the Savage
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  50.000, y = -0.700, z = -148.000 }
}

entity.phList =
{
    [ID.mob.AA_XALMO_THE_SAVAGE - 16] = ID.mob.AA_XALMO_THE_SAVAGE,
    [ID.mob.AA_XALMO_THE_SAVAGE - 5]  = ID.mob.AA_XALMO_THE_SAVAGE,
}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
