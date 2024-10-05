-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Cook Fulberry
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.ASTRAL_FLOW },
        },
    })
end

return entity
