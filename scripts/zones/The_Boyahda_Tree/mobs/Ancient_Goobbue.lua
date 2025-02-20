-----------------------------------
-- Area: The Boyahda Tree
--   NM: Ancient Goobbue
-----------------------------------
mixins =
{
    require('scripts/mixins/job_special'),
    require('scripts/mixins/draw_in'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.CRITHITRATE, 25)
    mob:setMobMod(xi.mobMod.GIL_MIN, 10000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 30000)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.HUNDRED_FISTS, cooldown = 60, hpp = math.random(85, 95) },
        },
    })
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
