-----------------------------------
-- Area: Cloister of Gales
--  Mob: Garuda Prime
-- Involved in Quest: Trial by Wind, Trial Size Trial by Wind
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = 875, hpp = math.random(30,55)}, -- uses Aerial Blast once while near 50% HPP.
        },
    })
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
end
