-----------------------------------
-- Area: Ship Bound for Mhaura
--   NM: Sea Horror
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.SHIP_BOUND_FOR_SELBINA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -0.230, y = -7.660, z = 2.860 }
}

entity.phList =
{
    [ID.mob.SEA_HORROR - 4] = ID.mob.SEA_HORROR, -- Sea Monk
}

entity.onMobInitialize = function(mob)
    -- "May despawn if left alone"
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    -- TODO any other immunities?
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
