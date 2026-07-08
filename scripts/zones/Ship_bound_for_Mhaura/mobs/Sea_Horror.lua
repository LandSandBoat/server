-----------------------------------
-- Area: Ship Bound for Mhaura
--   NM: Sea Horror
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.SHIP_BOUND_FOR_MHAURA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -0.329, y = -7.268, z = 5.820 }
}

entity.phList =
{
    [ID.mob.SEA_HORROR - 4] = ID.mob.SEA_HORROR, -- Sea Monk
}

entity.onMobInitialize = function(mob)
    -- "May despawn if left alone"
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.mobSkill.HUNDRED_FISTS_1 },
        },
    })
end

return entity
