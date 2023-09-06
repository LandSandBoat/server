-----------------------------------
-- Area: Apollyon CS
--  Mob: Grognard Impaler
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.CALL_WYVERN, hpp = 100 },
        },
    })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
