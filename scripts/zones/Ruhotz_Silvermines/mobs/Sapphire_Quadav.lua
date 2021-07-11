-----------------------------------
-- Area: Ruhotz Silvermines
--  Mob: Sapphire Quadav
-----------------------------------
require("scripts/globals/status")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.BENEDICTION, hpp = math.random(40, 60) },
        },
    })
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
