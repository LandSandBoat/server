-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Yarr the Pearleyed
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  3.000, y =  20.000, z = -140.000 }
}

entity.phList =
{
    [ID.mob.YARR_THE_PEARLEYED - 2] = ID.mob.YARR_THE_PEARLEYED, -- 1.654 19.914 -113.913
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 5)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 24)

    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 3000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.BENEDICTION, hpp = math.random(1, 50) } -- "Uses Benediction at around 50% or as low as 1%"
        }
    })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 377)
end

return entity
