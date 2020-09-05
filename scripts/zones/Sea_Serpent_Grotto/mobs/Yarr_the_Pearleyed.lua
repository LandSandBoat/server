-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Yarr the Pearleyed
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.BENEDICTION, hpp = math.random(1, 50)} -- "Uses Benediction at around 50% or as low as 1%"
        }
    })
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 377)
end
