-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Cook Minberry
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MIJIN_GAKURE },
        },
    })
end

return entity
