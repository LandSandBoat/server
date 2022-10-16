-----------------------------------
-- Area: Apollyon SW
--  NPC: Fir Bholg (PLD)
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------

local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.INVINCIBLE, hpp = math.random(50, 60) },
        },
    })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
