-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Titanis Jax
-- KSNM: Prehistoric Pigeons
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.SOUL_VOICE, cooldown = 200, hpp = 95},
        },
    })
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
