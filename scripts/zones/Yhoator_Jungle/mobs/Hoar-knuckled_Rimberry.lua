-----------------------------------
-- Area: Yhoator Jungle
--   NM: Hoar-knuckled Rimberry
--   WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity.
-----------------------------------
local ID = zones[xi.zone.YHOATOR_JUNGLE]
mixins = { require('scripts/mixins/families/tonberry') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  24.922, y = -5.023, z = -423.784 },
    { x =  31.930, y =  0.201, z = -407.700 }
}

entity.phList =
{
    [ID.mob.HOAR_KNUCKLED_RIMBERRY - 2] = ID.mob.HOAR_KNUCKLED_RIMBERRY,
    [ID.mob.HOAR_KNUCKLED_RIMBERRY - 1] = ID.mob.HOAR_KNUCKLED_RIMBERRY,
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 368)
    xi.regime.checkRegime(player, mob, 133, 1, xi.regime.type.FIELDS)
end

return entity
