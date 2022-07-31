-----------------------------------
-- Area: Al'Taieu
--  Mob: Qn'xzomit
-- Note: Pet for JOJ
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = xi.jsa.MIJIN_GAKURE, hpp = math.random(25, 35)},
        },
    })
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:addStatusEffectEx(xi.effect.FLEE, 0, 100, 0, 60)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
