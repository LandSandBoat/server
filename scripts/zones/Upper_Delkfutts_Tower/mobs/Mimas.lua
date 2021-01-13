-----------------------------------
-- Area: Upper Delkfutt's Tower
--   NM: Mimas
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.HUNDRED_FISTS},
        },
    })
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
