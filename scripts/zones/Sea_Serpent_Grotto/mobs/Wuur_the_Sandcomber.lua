-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Wuur the Sandcomber
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  16.000, y = -0.500, z =  120.000 }
}

entity.phList =
{
    [ID.mob.WUUR_THE_SANDCOMBER - 4] = ID.mob.WUUR_THE_SANDCOMBER, -- 14.044 0.494 109.487
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 5)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
    mob:setMobMod(xi.mobMod.GIL_MIN, 2400)
    mob:setMobMod(xi.mobMod.GIL_MAX, 2400)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGEN, 35)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 370)
end

return entity
