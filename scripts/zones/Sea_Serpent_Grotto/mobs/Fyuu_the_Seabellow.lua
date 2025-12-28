-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Fyuu the Seabellow
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  175.000, y =  20.000, z =  41.000 }
}

entity.phList =
{
    [ID.mob.FYUU_THE_SEABELLOW - 3] = ID.mob.FYUU_THE_SEABELLOW, -- 185.074 20.252 39.317
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 372)
end

return entity
