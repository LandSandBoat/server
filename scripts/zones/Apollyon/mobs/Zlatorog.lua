-----------------------------------
-- Area: Apollyon NW, Floor 2
--  Mob: Zlatorog
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MIGHTY_STRIKES, hpp = math.random(90, 95), cooldown = 90 },
        },
    })
end

return entity
