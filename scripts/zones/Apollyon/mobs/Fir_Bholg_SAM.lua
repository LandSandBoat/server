-----------------------------------
-- Area: Apollyon SW
--  NPC: Fir Bholg (SAM)
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------

local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MEIKYO_SHISUI, hpp = math.random(50, 60) },
        },
    })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
