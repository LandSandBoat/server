-----------------------------------
-- Area: Giddeus
--   NM: Vaa Huja the Erudite
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MANAFONT, chance = math.random(30,80) },
        },
    })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
