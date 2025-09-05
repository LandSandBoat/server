-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Pahh the Gullcaller
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -2.000, y =  21.000, z = -19.000 }
}

entity.phList =
{
    [ID.mob.PAHH_THE_GULLCALLER - 5] = ID.mob.PAHH_THE_GULLCALLER, -- -13.532 21.301 -20.861
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 375)
end

return entity
