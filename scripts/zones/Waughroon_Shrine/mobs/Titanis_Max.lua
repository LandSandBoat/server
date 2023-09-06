-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Titanis Max
-- KSNM: Prehistoric Pigeons
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.SOUL_VOICE, cooldown = 200, hpp = 95 },
        },
    })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
