-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Cook Nalberry
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.PERFECT_DODGE },
        },
    })
end

return entity
