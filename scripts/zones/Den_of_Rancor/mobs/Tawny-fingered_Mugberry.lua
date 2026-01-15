-----------------------------------
-- Area: Den of Rancor
--   NM: Tawny-fingered Mugberry
-----------------------------------
mixins =
{
    require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  100.000, y =  17.000, z = -180.000 }
}

entity.phList =
{
    [ID.mob.TAWNY_FINGERED_MUGBERRY - 14] = ID.mob.TAWNY_FINGERED_MUGBERRY,
    [ID.mob.TAWNY_FINGERED_MUGBERRY - 13] = ID.mob.TAWNY_FINGERED_MUGBERRY,
    [ID.mob.TAWNY_FINGERED_MUGBERRY - 11] = ID.mob.TAWNY_FINGERED_MUGBERRY,
    [ID.mob.TAWNY_FINGERED_MUGBERRY - 10] = ID.mob.TAWNY_FINGERED_MUGBERRY,
    [ID.mob.TAWNY_FINGERED_MUGBERRY - 5]  = ID.mob.TAWNY_FINGERED_MUGBERRY,
    [ID.mob.TAWNY_FINGERED_MUGBERRY - 4]  = ID.mob.TAWNY_FINGERED_MUGBERRY,
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)

    mob:setMobMod(xi.mobMod.GIL_MIN, 6000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 6000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 396)
end

return entity
