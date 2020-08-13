-----------------------------------
-- Area: Cloister of Tides
--  Mob: Leviathan Prime
-- Involved in Quest: Trial by Water, Trial Size Trial by Water
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = 866, hpp = math.random(30,55)}, -- uses Tidal Wave once while near 50% HPP.
        },
    })
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
end
