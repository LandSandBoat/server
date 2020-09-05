-----------------------------------
-- Area: Cloister of Flames
--  Mob: Ifrit Prime
-- Involved in Quest: Trial by Fire, Trial Size Trial by Fire
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = 848, hpp = math.random(30,55)}, -- uses Inferno once while near 50% HPP.
        },
    })
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
end
