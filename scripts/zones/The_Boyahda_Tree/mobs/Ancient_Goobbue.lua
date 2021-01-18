-----------------------------------
-- Area: The Boyahda Tree
--   NM: Ancient Goobbue
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(tpz.mod.CRITHITRATE, 25)
end

entity.onMobSpawn = function(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.HUNDRED_FISTS, cooldown = 60, hpp = math.random(85, 95)},
        },
    })
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
