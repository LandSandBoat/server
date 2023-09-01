-----------------------------------
-- Area: Cloister of Gales
--  Mob: Garuda Prime
-- Involved in Quest: Trial by Wind, Trial Size Trial by Wind
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = 875, hpp = math.random(30, 55) }, -- uses Aerial Blast once while near 50% HPP.
        },
    })
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
