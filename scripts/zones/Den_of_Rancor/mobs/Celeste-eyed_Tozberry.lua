-----------------------------------
-- Area: Den of Rancor
--   NM: Celeste-eyed Tozberry
-----------------------------------
mixins =
{
    require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MIJIN_GAKURE, hpp = math.random(20, 30) },
        },
    })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 395)
end

return entity
