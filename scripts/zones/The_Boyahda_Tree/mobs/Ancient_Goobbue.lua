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
    mob:setMobMod(xi.mobMod.GIL_MIN, 20000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 20000)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.CRITHITRATE, 25)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.mobSkill.HUNDRED_FISTS_1 },
            { id = xi.mobSkill.HUNDRED_FISTS_1, cooldown = 65, hpp = math.randomInt(98, 99) },
        },
    })
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(75600, 86400)) -- 21 to 24 hours
end

return entity
