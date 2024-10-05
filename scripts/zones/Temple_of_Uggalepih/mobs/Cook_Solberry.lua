-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Cook Solberry
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MANAFONT },
        },
    })
end

return entity
