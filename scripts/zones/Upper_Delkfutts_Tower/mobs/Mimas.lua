-----------------------------------
-- Area: Upper Delkfutt's Tower
--   NM: Mimas
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.HUNDRED_FISTS},
        },
    })
end

function onMobDeath(mob, player, isKiller)
end
