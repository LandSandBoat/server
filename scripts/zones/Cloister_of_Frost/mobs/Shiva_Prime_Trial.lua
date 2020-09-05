-----------------------------------
-- Area: Cloister of Frost
-- Mob: Shiva Prime
-- Involved in Quest: Trial by Ice, Trial Size Trial by Ice
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = 884, hpp = math.random(30,55)}, -- uses Diamond Dust once while near 50% HPP.
        },
    })
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
end
