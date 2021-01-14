-----------------------------------
-- Area: Cloister of Flames
--  Mob: Ifrit Prime
-- Involved in Quest: Trial by Fire, Trial Size Trial by Fire
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = 848, hpp = math.random(30,55)}, -- uses Inferno once while near 50% HPP.
        },
    })
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
