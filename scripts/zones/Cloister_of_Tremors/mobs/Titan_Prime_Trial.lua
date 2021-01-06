-----------------------------------
-- Area: Cloister of Tremors
--  Mob: Titan Prime
-- Involved in Quest: Trial by Earth, Trial Size Trial by Earth
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = 857, hpp = math.random(30,55)}, -- uses Earthen Fury once while near 50% HPP.
        },
    })
end

entity.onMobFight = function(mob, target)
end

function onMobDeath(mob, player, isKiller)
end

return entity
