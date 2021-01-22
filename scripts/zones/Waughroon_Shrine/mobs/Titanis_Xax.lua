-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Titanis Xax
-- KSNM: Prehistoric Pigeons
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
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
