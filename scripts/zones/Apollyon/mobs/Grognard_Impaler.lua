-----------------------------------
-- Area: Apollyon CS
--  Mob: Grognard Impaler
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.CALL_WYVERN, hpp = 100},
        },
    })
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
