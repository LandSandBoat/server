-----------------------------------
-- Area: Den of Rancor
--   NM: Bistre-hearted Malberry
-----------------------------------
mixins =
{
    require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -32.000, y =  16.000, z = -178.000 }
}

entity.phList =
{
    [ID.mob.BISTRE_HEARTED_MALBERRY - 23] = ID.mob.BISTRE_HEARTED_MALBERRY,
}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MANAFONT, hpp = math.random(40, 95) },
        },
    })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 397)
end

return entity
