-----------------------------------
-- Area: Apollyon SE, Floor 2
--  Mob: Tieholtsodi
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.mobSkill.HUNDRED_FISTS_1, hpp = 50 },
        },
    })
end

return entity
