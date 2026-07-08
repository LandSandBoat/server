-----------------------------------
-- Area: Mamook
--   NM: Zizzy Zillah
-----------------------------------
mixins = { require('scripts/mixins/families/ziz') }
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  83.000, y =  14.500, z = -222.000 }
}

entity.phList =
{
    [ID.mob.ZIZZY_ZILLAH + 6]  = ID.mob.ZIZZY_ZILLAH,
    [ID.mob.ZIZZY_ZILLAH + 7]  = ID.mob.ZIZZY_ZILLAH,
    [ID.mob.ZIZZY_ZILLAH + 8]  = ID.mob.ZIZZY_ZILLAH,
    [ID.mob.ZIZZY_ZILLAH + 9]  = ID.mob.ZIZZY_ZILLAH,
    [ID.mob.ZIZZY_ZILLAH + 10] = ID.mob.ZIZZY_ZILLAH,
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 175)
    mob:setMod(xi.mod.REGAIN, 300) -- TP move every 25 seconds or so with no TP feed
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 460)
end

return entity
