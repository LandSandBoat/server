-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Yarr the Pearleyed
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  3.000, y =  20.000, z = -140.000 }
}

entity.phList =
{
    [ID.mob.YARR_THE_PEARLEYED - 2] = ID.mob.YARR_THE_PEARLEYED, -- 1.654 19.914 -113.913
}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.BENEDICTION, hpp = math.random(1, 50) } -- "Uses Benediction at around 50% or as low as 1%"
        }
    })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 377)
end

return entity
