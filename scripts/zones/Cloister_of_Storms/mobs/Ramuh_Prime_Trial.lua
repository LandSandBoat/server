-----------------------------------
-- Area: Cloister of Storms
--  Mob: Ramuh Prime
-- Involved in Quest: Trial by Lightning, Trial Size Trial by Lightning
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = 893, hpp = math.random(30,55)}, -- uses Judgment Bolt once while near 50% HPP.
        },
    })
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
end
