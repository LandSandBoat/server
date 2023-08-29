-----------------------------------
-- Area: Apollyon SE, Floor 2
--  Mob: Tieholtsodi
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.HUNDRED_FISTS, hpp = 50 },
        },
    })
end

return entity
