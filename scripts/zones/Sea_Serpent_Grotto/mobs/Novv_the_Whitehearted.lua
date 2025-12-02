-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Novv the Whitehearted
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -37.000, y =  19.000, z = -205.000 }
}

entity.phList =
{
    [ID.mob.NOVV_THE_WHITEHEARTED - 1] = ID.mob.NOVV_THE_WHITEHEARTED,
}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
